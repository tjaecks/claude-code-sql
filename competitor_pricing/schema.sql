-- Swiss Mobile Prepaid Tariff Database
-- Operators: Swisscom, Sunrise, Salt
-- Data collected: 2026-03-26

CREATE DATABASE IF NOT EXISTS swiss_telco_pricing
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE swiss_telco_pricing;

DROP TABLE IF EXISTS prepaid_tariffs;

CREATE TABLE prepaid_tariffs (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    operator        VARCHAR(50)     NOT NULL COMMENT 'Telco operator name',
    tariff_name     VARCHAR(100)    NOT NULL COMMENT 'Product/plan name',
    tier_name       VARCHAR(100)    NOT NULL COMMENT 'Specific tier or sub-plan',
    -- 5 core tariff attributes --
    price_chf       DECIMAL(8,2)    NOT NULL COMMENT 'Plan price in CHF',
    price_period    VARCHAR(20)     NOT NULL COMMENT 'Billing period: daily|7-days|15-days|30-days|90-days|pay-per-use',
    data_gb         DECIMAL(8,3)    DEFAULT NULL COMMENT 'Data allowance in GB; NULL = pay-per-use or N/A',
    data_unlimited  TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1 = unlimited data included',
    validity_days   SMALLINT        DEFAULT NULL COMMENT 'Plan validity in days; NULL = no fixed expiry',
    -- supplementary fields --
    minutes_included SMALLINT       DEFAULT NULL COMMENT 'Included minutes; -1 = unlimited; NULL = pay-per-use',
    sms_unlimited   TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '1 = unlimited SMS included',
    notes           VARCHAR(255)    DEFAULT NULL,
    source_url      VARCHAR(300)    DEFAULT NULL,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_operator (operator),
    INDEX idx_tariff (tariff_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
