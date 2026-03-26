"""
Swiss Prepaid Tariff Database Seeder
Source data fetched from Swisscom, Sunrise and Salt websites (2026-03-26)

Usage:
    pip install mysql-connector-python
    python seed_data.py [--host HOST] [--user USER] [--password PASSWORD]
"""

import argparse
import mysql.connector
from mysql.connector import Error

# ─────────────────────────────────────────────────────────────────────────────
# DATA VECTOR  –  one dict per tariff row
# Keys: operator, tariff_name, tier_name,
#       price_chf, price_period,
#       data_gb (float or None),  data_unlimited (bool),
#       validity_days (int or None),
#       minutes_included (-1=unlimited, int, or None),  sms_unlimited (bool),
#       notes, source_url
# ─────────────────────────────────────────────────────────────────────────────

TARIFF_DATA = [

    # ── SWISSCOM ──────────────────────────────────────────────────────────────
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Basic",
        "tier_name":         "Basic",
        "price_chf":         0.00,
        "price_period":      "pay-per-use",
        "data_gb":           None,           # CHF 2/day when used
        "data_unlimited":    False,
        "validity_days":     None,           # credit never expires
        "minutes_included":  None,           # CHF 0.29/min
        "sms_unlimited":     False,          # CHF 0.15/SMS
        "notes":             "CHF 0.29/min calls; CHF 0.15/SMS; CHF 2/day data; no base fee",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/inone-mobile-prepaid-basic-tariff.html",
    },
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Plus",
        "tier_name":         "Plus",
        "price_chf":         5.00,
        "price_period":      "30-days",
        "data_gb":           None,           # throttled unlimited at 128 kbit/s
        "data_unlimited":    True,
        "validity_days":     30,
        "minutes_included":  None,           # CHF 0.29/min
        "sms_unlimited":     True,
        "notes":             "Unlimited SMS CH+abroad; data at 128 kbit/s; calls CHF 0.29/min; auto-renews",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/plus.html",
    },
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Flat",
        "tier_name":         "7 days",
        "price_chf":         20.00,
        "price_period":      "7-days",
        "data_gb":           None,
        "data_unlimited":    True,           # unlimited at 50 Mbit/s
        "validity_days":     7,
        "minutes_included":  -1,             # unlimited
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data (50 Mbit/s) in Switzerland; tourist SIM",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/tourists.html",
    },
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Flat",
        "tier_name":         "15 days",
        "price_chf":         40.00,
        "price_period":      "15-days",
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     15,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data (50 Mbit/s) in Switzerland; tourist SIM",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/tourists.html",
    },
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Flat",
        "tier_name":         "30 days",
        "price_chf":         65.00,
        "price_period":      "30-days",
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     30,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data (50 Mbit/s) in Switzerland; tourist SIM",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/tourists.html",
    },
    {
        "operator":          "Swisscom",
        "tariff_name":       "Prepaid Flat",
        "tier_name":         "90 days",
        "price_chf":         150.00,
        "price_period":      "90-days",
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     90,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data (50 Mbit/s) in Switzerland; tourist SIM",
        "source_url":        "https://www.swisscom.ch/en/residential/mobile-subscription/prepaid/tourists.html",
    },

    # ── SUNRISE ───────────────────────────────────────────────────────────────
    {
        "operator":          "Sunrise",
        "tariff_name":       "Prepaid Airbag",
        "tier_name":         "Base",
        "price_chf":         0.00,
        "price_period":      "pay-per-use",
        "data_gb":           0.300,          # 300 MB/day fair-use cap
        "data_unlimited":    False,
        "validity_days":     None,
        "minutes_included":  None,           # CHF 0.30/min
        "sms_unlimited":     False,          # CHF 0.20/SMS
        "notes":             "CHF 0.30/min; CHF 0.20/SMS; 300 MB/day; speed throttled after 100 MB/day",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Prepaid Unlimited",
        "tier_name":         "Daily Pass",
        "price_chf":         2.50,
        "price_period":      "daily",
        "data_gb":           None,
        "data_unlimited":    True,           # up to 150 Mbit/s
        "validity_days":     1,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data (150 Mbit/s) for 24 hours",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Prepaid Unlimited",
        "tier_name":         "30 days",
        "price_chf":         50.00,
        "price_period":      "30-days",
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     30,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data for 30 days",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Prepaid Unlimited",
        "tier_name":         "90 days",
        "price_chf":         40.00,
        "price_period":      "30-days",     # CHF 40/month billed over 90-day commitment
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     90,
        "minutes_included":  -1,
        "sms_unlimited":     True,
        "notes":             "Unlimited calls/SMS/data; CHF 40/month on 90-day plan (vs CHF 50 for 30-day)",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Budget",
        "tier_name":         "Budget 10",
        "price_chf":         10.00,
        "price_period":      "30-days",
        "data_gb":           0.300,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  30,
        "sms_unlimited":     False,          # 30 SMS included
        "notes":             "300 MB data + 30 min + 30 SMS; overage at standard rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Budget",
        "tier_name":         "Budget 15",
        "price_chf":         15.00,
        "price_period":      "30-days",
        "data_gb":           0.600,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  60,
        "sms_unlimited":     False,          # 60 SMS included
        "notes":             "600 MB data + 60 min + 60 SMS; overage at standard rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Data Option",
        "tier_name":         "Data S",
        "price_chf":         7.50,
        "price_period":      "30-days",
        "data_gb":           0.500,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "500 MB data add-on; calls/SMS at standard Airbag rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Data Option",
        "tier_name":         "Data M",
        "price_chf":         10.00,
        "price_period":      "30-days",
        "data_gb":           1.000,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "1 GB data add-on; calls/SMS at standard Airbag rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Data Option",
        "tier_name":         "Data L",
        "price_chf":         20.00,
        "price_period":      "30-days",
        "data_gb":           3.000,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "3 GB data add-on; calls/SMS at standard Airbag rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },
    {
        "operator":          "Sunrise",
        "tariff_name":       "Airbag + Data Option",
        "tier_name":         "Data XL",
        "price_chf":         45.00,
        "price_period":      "30-days",
        "data_gb":           10.000,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "10 GB data add-on; calls/SMS at standard Airbag rates",
        "source_url":        "https://www.sunrise.ch/en/mobile/prepaid/options",
    },

    # ── SALT ──────────────────────────────────────────────────────────────────
    {
        "operator":          "Salt",
        "tariff_name":       "PrePay",
        "tier_name":         "Base",
        "price_chf":         0.00,
        "price_period":      "pay-per-use",
        "data_gb":           None,           # CHF 1.99/day data
        "data_unlimited":    False,
        "validity_days":     None,
        "minutes_included":  None,           # CHF 0.49/call (max 60 min)
        "sms_unlimited":     False,          # CHF 0.12/SMS
        "notes":             "CHF 0.49/call (max 60 min); CHF 0.12/SMS; data CHF 1.99/day; free SIM + CHF 10 credit",
        "source_url":        "https://www.salt.ch/en/mobile/plan/prepay",
    },
    {
        "operator":          "Salt",
        "tariff_name":       "PrePay Data Pack",
        "tier_name":         "100 MB",
        "price_chf":         3.00,
        "price_period":      "30-days",
        "data_gb":           0.100,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "100 MB data valid 30 days; calls/SMS at base rates",
        "source_url":        "https://www.salt.ch/en/mobile/plan/prepay",
    },
    {
        "operator":          "Salt",
        "tariff_name":       "PrePay Data Pack",
        "tier_name":         "500 MB",
        "price_chf":         9.00,
        "price_period":      "30-days",
        "data_gb":           0.500,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "500 MB data valid 30 days; calls/SMS at base rates",
        "source_url":        "https://www.salt.ch/en/mobile/plan/prepay",
    },
    {
        "operator":          "Salt",
        "tariff_name":       "PrePay Data Pack",
        "tier_name":         "1 GB",
        "price_chf":         15.00,
        "price_period":      "30-days",
        "data_gb":           1.000,
        "data_unlimited":    False,
        "validity_days":     30,
        "minutes_included":  None,
        "sms_unlimited":     False,
        "notes":             "1 GB data valid 30 days; calls/SMS at base rates",
        "source_url":        "https://www.salt.ch/en/mobile/plan/prepay",
    },
    {
        "operator":          "Salt",
        "tariff_name":       "PrePay Unlimited Surf",
        "tier_name":         "Daily",
        "price_chf":         1.99,
        "price_period":      "daily",
        "data_gb":           None,
        "data_unlimited":    True,
        "validity_days":     1,
        "minutes_included":  None,           # calls still at CHF 0.49/call
        "sms_unlimited":     False,
        "notes":             "Unlimited daily data; calls/SMS still at base rates",
        "source_url":        "https://www.salt.ch/en/mobile/plan/prepay",
    },
]


# ─────────────────────────────────────────────────────────────────────────────
# DATABASE OPERATIONS
# ─────────────────────────────────────────────────────────────────────────────

DDL = """
CREATE DATABASE IF NOT EXISTS swiss_telco_pricing
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
"""

CREATE_TABLE = """
CREATE TABLE IF NOT EXISTS swiss_telco_pricing.prepaid_tariffs (
    id               INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    operator         VARCHAR(50)   NOT NULL,
    tariff_name      VARCHAR(100)  NOT NULL,
    tier_name        VARCHAR(100)  NOT NULL,
    price_chf        DECIMAL(8,2)  NOT NULL,
    price_period     VARCHAR(20)   NOT NULL,
    data_gb          DECIMAL(8,3)  DEFAULT NULL,
    data_unlimited   TINYINT(1)    NOT NULL DEFAULT 0,
    validity_days    SMALLINT      DEFAULT NULL,
    minutes_included SMALLINT      DEFAULT NULL,
    sms_unlimited    TINYINT(1)    NOT NULL DEFAULT 0,
    notes            VARCHAR(255)  DEFAULT NULL,
    source_url       VARCHAR(300)  DEFAULT NULL,
    updated_at       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_operator  (operator),
    INDEX idx_tariff    (tariff_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
"""

INSERT_SQL = """
INSERT INTO swiss_telco_pricing.prepaid_tariffs
    (operator, tariff_name, tier_name,
     price_chf, price_period,
     data_gb, data_unlimited, validity_days,
     minutes_included, sms_unlimited,
     notes, source_url)
VALUES
    (%(operator)s, %(tariff_name)s, %(tier_name)s,
     %(price_chf)s, %(price_period)s,
     %(data_gb)s, %(data_unlimited)s, %(validity_days)s,
     %(minutes_included)s, %(sms_unlimited)s,
     %(notes)s, %(source_url)s)
"""


def seed(host="localhost", user="root", password="", port=3306):
    try:
        conn = mysql.connector.connect(
            host=host, user=user, password=password, port=port
        )
        cursor = conn.cursor()

        cursor.execute(DDL)
        cursor.execute(CREATE_TABLE)
        conn.commit()

        # Truncate before re-seeding to keep idempotent
        cursor.execute("TRUNCATE TABLE swiss_telco_pricing.prepaid_tariffs")

        # Convert bool to int for MySQL TINYINT
        rows = []
        for row in TARIFF_DATA:
            r = dict(row)
            r["data_unlimited"] = int(r["data_unlimited"])
            r["sms_unlimited"]  = int(r["sms_unlimited"])
            rows.append(r)

        cursor.executemany(INSERT_SQL, rows)
        conn.commit()

        print(f"✓ Inserted {cursor.rowcount} tariff rows into swiss_telco_pricing.prepaid_tariffs")

        # Quick verification
        cursor.execute(
            "SELECT operator, COUNT(*) FROM swiss_telco_pricing.prepaid_tariffs GROUP BY operator"
        )
        for op, cnt in cursor.fetchall():
            print(f"  {op}: {cnt} rows")

    except Error as e:
        print(f"MySQL error: {e}")
        raise
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Seed Swiss prepaid tariff database")
    parser.add_argument("--host",     default="localhost")
    parser.add_argument("--port",     default=3306, type=int)
    parser.add_argument("--user",     default="root")
    parser.add_argument("--password", default="")
    args = parser.parse_args()

    seed(host=args.host, user=args.user, password=args.password, port=args.port)
