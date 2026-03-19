-- Products / Inventory Table
CREATE TABLE products (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255)   NOT NULL,
    sku         VARCHAR(100)   UNIQUE,
    description TEXT,
    price       DECIMAL(10, 2) NOT NULL,
    quantity    INT UNSIGNED   NOT NULL DEFAULT 0,
    category    VARCHAR(100),
    is_active   BOOLEAN        NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dummy Data
INSERT INTO products (name, sku, description, price, quantity, category, is_active) VALUES
('Wireless Mouse',        'SKU-001', 'Ergonomic 2.4GHz wireless mouse with USB receiver',     29.99,  150, 'Electronics',   TRUE),
('Mechanical Keyboard',   'SKU-002', 'TKL mechanical keyboard with blue switches',            79.99,   85, 'Electronics',   TRUE),
('USB-C Hub 7-in-1',      'SKU-003', '7-port hub with HDMI, USB 3.0, and PD charging',       49.99,   60, 'Electronics',   TRUE),
('Standing Desk Mat',     'SKU-004', 'Anti-fatigue foam mat, 30x20 inches',                  39.99,  200, 'Office',        TRUE),
('Laptop Stand',          'SKU-005', 'Adjustable aluminum laptop stand, fits 11-17 inch',    34.99,  120, 'Office',        TRUE),
('LED Desk Lamp',         'SKU-006', 'Touch-control lamp with 3 color modes and USB port',   24.99,   95, 'Office',        TRUE),
('Webcam 1080p',          'SKU-007', 'Full HD webcam with built-in noise-canceling mic',      59.99,   45, 'Electronics',   TRUE),
('Cable Management Box',  'SKU-008', 'Desktop organizer box for power strips and cables',    19.99,  300, 'Office',        TRUE),
('Monitor Light Bar',     'SKU-009', 'Clip-on LED light bar for monitor, auto-dimming',      42.99,   70, 'Electronics',   FALSE),
('Desk Organizer Set',    'SKU-010', '5-piece bamboo desk organizer with pen holder',        27.99,  180, 'Office',        TRUE);
