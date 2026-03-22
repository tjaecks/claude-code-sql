-- ============================================================
-- Swiss 4000m Peaks Database
-- Source: UIAA official list, Wikipedia, Swisstopo
-- Distance calculated from Richterswil (47.2050°N, 8.8381°E)
-- ============================================================

CREATE TABLE swiss_4000ers (
    id                      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name                    VARCHAR(100)    NOT NULL,
    name_local              VARCHAR(200),               -- German/French/Italian alternate names
    massif                  VARCHAR(100),               -- Mountain group/massif
    range                   VARCHAR(100),               -- Mountain range
    elevation_m             INT             NOT NULL,   -- Summit elevation in metres
    latitude                DECIMAL(9,6)    NOT NULL,   -- WGS84 decimal degrees
    longitude               DECIMAL(9,6)    NOT NULL,   -- WGS84 decimal degrees
    prominence_m            INT,                        -- Topographic prominence in metres
    isolation_km            DECIMAL(6,1),               -- Distance to nearest higher peak (km)
    first_ascent_year       SMALLINT,                   -- Year of first recorded ascent
    first_ascent_party      TEXT,                       -- Names of first ascent party
    cantons                 VARCHAR(50),                -- Swiss canton(s); /IT or /FR for border peaks
    uiaa_list               BOOLEAN         NOT NULL DEFAULT TRUE,  -- On official UIAA 82-peak list
    uiaa_rank               SMALLINT,                   -- Rank on UIAA list by elevation
    dist_richterswil_km     DECIMAL(6,1),               -- Air distance from Richterswil 8805 (km)
    trailhead_name          VARCHAR(200),               -- Last car park / public transport stop for normal route
    trailhead_description   TEXT,                       -- Short route approach & travel info (source: SAC Tourenportal)
    trailhead_lat           DECIMAL(9,6),               -- WGS84 latitude of trailhead
    trailhead_lon           DECIMAL(9,6),               -- WGS84 longitude of trailhead
    notes                   TEXT,
    created_at              TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- DATA — 50 peaks (48 Swiss UIAA peaks + Vincent Pyramid)
-- ============================================================

INSERT INTO swiss_4000ers
    (name, name_local, massif, range, elevation_m, latitude, longitude,
     prominence_m, isolation_km, first_ascent_year, first_ascent_party,
     cantons, uiaa_list, uiaa_rank, dist_richterswil_km,
     trailhead_name, trailhead_description, trailhead_lat, trailhead_lon, notes)
VALUES

-- MONTE ROSA MASSIF
('Dufourspitze',        'Pointe Dufour',
 'Monte Rosa', 'Pennine Alps',
 4634, 45.936833, 7.867056, 2165, 78.3,
 1855, 'Hudson, Smyth, Birkbeck, Grenville-Wells, Stevenson, Lauener, Zumtaugwald',
 'VS/IT', TRUE, 3, 159.4,
 'Highest peak in Switzerland; 2nd highest in Alps'),

('Nordend',             'Punta Nord',
 'Monte Rosa', 'Pennine Alps',
 4609, 45.942222, 7.870000, 89, 0.6,
 1861, 'Buxton, Buxton, Cowell, Payot, Binder',
 'VS/IT', TRUE, 4, 158.7, NULL),

('Zumsteinspitze',      'Punta Zumstein',
 'Monte Rosa', 'Pennine Alps',
 4563, 45.931944, 7.871389, 112, 0.5,
 1820, 'Zumstein, Vincent, Vincent et al.',
 'VS/IT', TRUE, 5, 159.7, NULL),

('Signalkuppe',         'Punta Gnifetti',
 'Monte Rosa', 'Pennine Alps',
 4554, 45.927222, 7.876944, 98, 0.7,
 1842, 'Giovanni Gnifetti and 7 companions',
 'VS/IT', TRUE, 6, 160.0,
 'Site of Capanna Regina Margherita – highest staffed hut in Europe'),

('Parrotspitze',        'Punta Parrot',
 'Monte Rosa', 'Pennine Alps',
 4434, 45.919722, 7.871389, 134, 0.9,
 1863, 'Grove, Anderegg et al.',
 'VS/IT', TRUE, 15, 160.9, NULL),

('Ludwigshoehe',        'Punta Luigi Amedeo di Savoia',
 'Monte Rosa', 'Pennine Alps',
 4341, 45.917222, 7.862222, 57, 0.7,
 1822, 'Ludwig von Welden and companions',
 'VS/IT', TRUE, 17, 161.5, NULL),

('Schwarzhorn',         'Corno Nero',
 'Monte Rosa', 'Pennine Alps',
 4321, 45.914900, 7.862000, 42, 0.3,
 1873, 'Maglioni, Rothschild, Cupelin, Knubel et al.',
 'IT/VS', TRUE, 19, 161.7,
 'Summit technically in Italy on Monte Rosa border ridge'),

('Vincent Pyramid',     'Piramide Vincent / Vincentpyramide',
 'Monte Rosa', 'Pennine Alps',
 4215, 45.907778, 7.861944, 128, 0.7,
 1819, 'Johann Nikolaus Vincent and three companions',
 'IT', TRUE, 30, 162.4,
 'Summit in Italy (Aosta Valley); included in UIAA 82-peak list'),

-- MISCHABEL GROUP
('Dom',                 NULL,
 'Mischabel', 'Pennine Alps',
 4546, 46.095000, 7.860000, 1057, 16.9,
 1858, 'Davies, Zumtaugwald, Kronig, Brantschen',
 'VS', TRUE, 7, 144.2,
 'Highest peak entirely within Switzerland'),

('Taeschhorn',          'Täschhorn',
 'Mischabel', 'Pennine Alps',
 4491, 46.083611, 7.857222, 213, 1.2,
 1862, 'Davies, Hayward, Summermatter, Zumtaugwald',
 'VS', TRUE, 10, 145.4, NULL),

('Nadelhorn',           NULL,
 'Mischabel', 'Pennine Alps',
 4327, 46.108750, 7.864167, 207, 1.7,
 1858, 'Andenmatten, Epiney, Supersaxo, Zimmermann',
 'VS', TRUE, 18, 142.8, NULL),

('Lenzspitze',          NULL,
 'Mischabel', 'Pennine Alps',
 4294, 46.104639, 7.868444, 86, 0.5,
 1870, 'Dent, Burgener, Burgener',
 'VS', TRUE, 22, 143.0, NULL),

('Stecknadelhorn',      NULL,
 'Mischabel', 'Pennine Alps',
 4241, 46.111528, 7.859667, 27, 0.5,
 1887, 'Eckenstein, Zurbriggen',
 'VS', TRUE, 26, 142.7, NULL),

('Hohberghorn',         NULL,
 'Mischabel', 'Pennine Alps',
 4219, 46.112694, 7.853861, 76, 0.4,
 1869, 'Heathcote, Biner, Perren, Taugwalder',
 'VS', TRUE, 29, 142.8, NULL),

('Duerrenhorn',         'Dürrenhorn',
 'Mischabel', 'Pennine Alps',
 4035, 46.119722, 7.848056, 124, 0.8,
 1879, 'Mummery, Penhall, Burgener, Imseng',
 'VS', TRUE, 72, 142.4, NULL),

('Alphubel',            NULL,
 'Mischabel', 'Pennine Alps',
 4206, 46.062939, 7.863911, 359, 2.3,
 1860, 'Hinchliff, Stephen, Anderegg, Perren',
 'VS', TRUE, 32, 147.2, NULL),

('Rimpfischhorn',       NULL,
 'Mischabel', 'Pennine Alps',
 4199, 46.023056, 7.883889, 647, 4.7,
 1859, 'Stephen, Liveing, Anderegg, Zumtaugwald',
 'VS', TRUE, 33, 150.3, NULL),

('Strahlhorn',          NULL,
 'Mischabel', 'Pennine Alps',
 4190, 46.013222, 7.901750, 404, 1.8,
 1854, 'Grenville, Smyth, Andenmatten, Lauener',
 'VS', TRUE, 35, 150.6, NULL),

('Allalinhorn',         NULL,
 'Mischabel', 'Pennine Alps',
 4027, 46.046139, 7.894806, 257, 2.1,
 1856, 'Ames, Imseng, Andenmatten',
 'VS', TRUE, 73, 147.6, NULL),

-- WEISSHORN / ZINALROTHORN
('Weisshorn',           NULL,
 'Weisshorn', 'Pennine Alps',
 4506, 46.101667, 7.716111, 1234, 11.1,
 1861, 'Tyndall, Brennen, Wenger',
 'VS', TRUE, 9, 149.6, NULL),

('Bishorn',             'Pointe de Bies',
 'Weisshorn', 'Pennine Alps',
 4153, 46.117778, 7.714722, 90, 0.8,
 1884, 'Barnes, Chessyre-Walker, Imboden, Chanton',
 'VS', TRUE, 42, 148.2, NULL),

('Dent Blanche',        NULL,
 'Dent Blanche', 'Pennine Alps',
 4357, 46.034167, 7.611944, 916, 7.4,
 1862, 'Kennedy, Wigram, Wigram, Croz, Kronig',
 'VS', TRUE, 16, 160.4, NULL),

('Zinalrothorn',        'Rothorn de Zinal',
 'Zinalrothorn', 'Pennine Alps',
 4221, 46.064722, 7.690000, 491, 4.5,
 1864, 'Grove, Stephen, J.Anderegg, M.Anderegg',
 'VS', TRUE, 28, 154.1, NULL),

('Ober Gabelhorn',      NULL,
 'Ober Gabelhorn', 'Pennine Alps',
 4063, 46.038333, 7.667778, 536, 3.1,
 1865, 'Walker, Moore, Anderegg',
 'VS', TRUE, 62, 157.5, NULL),

-- WEISSMIES GROUP
('Weissmies',           NULL,
 'Weissmies', 'Pennine Alps',
 4017, 46.127778, 8.011944, 1183, 11.2,
 1855, 'Heusser, Zurbriggen',
 'VS', TRUE, 77, 135.4, NULL),

('Lagginhorn',          'Laquinhorn',
 'Weissmies', 'Pennine Alps',
 4010, 46.157222, 8.003056, 512, 3.3,
 1856, 'Ames, Imseng, Andenmatten',
 'VS', TRUE, 79, 132.8, NULL),

-- MATTERHORN / LYSKAMM / BREITHORN CHAIN
('Lyskamm Ostgipfel',   'Liskamm Orientale / Lyskamm Eastern Summit',
 'Monte Rosa', 'Pennine Alps',
 4533, 45.922500, 7.835556, 379, 2.9,
 1861, 'Hall and 13 companions',
 'VS/IT', TRUE, 8, 161.9, NULL),

('Lyskamm Westgipfel',  'Liskamm Occidentale / Lyskamm Western Summit',
 'Monte Rosa', 'Pennine Alps',
 4479, 45.926512, 7.823322, 73, 1.1,
 1864, 'Stephen, Buxton, J.Anderegg, Biner',
 'VS/IT', TRUE, 11, 161.9, NULL),

('Matterhorn',          'Monte Cervino / Mont Cervin',
 'Matterhorn', 'Pennine Alps',
 4478, 45.976389, 7.658611, 1043, 13.9,
 1865, 'Croz, Taugwalder Sr., Taugwalder Jr., Whymper, Hudson, Douglas, Hadow',
 'VS/IT', TRUE, 12, 163.7,
 'First ascent ended in tragedy on descent; 4 of 7 climbers died'),

('Dent d Herens',       "Dent d'Hérens / Dente d'Hérens",
 'Matterhorn', 'Pennine Alps',
 4173, 45.970056, 7.605083, 704, 4.2,
 1863, 'Grove, Anderegg et al.',
 'VS/IT', TRUE, 38, 166.5, NULL),

('Castor',              'Castore',
 'Breithorn', 'Pennine Alps',
 4228, 45.922222, 7.792778, 156, 2.4,
 1861, 'Mathews, Jacomb, Croz',
 'VS/IT', TRUE, 27, 163.5, NULL),

('Pollux',              'Polluce',
 'Breithorn', 'Pennine Alps',
 4092, 45.927778, 7.785278, 243, 0.7,
 1864, 'Jacot, Perren, Taugwalder Sr.',
 'VS/IT', TRUE, 55, 163.2, NULL),

('Breithorn West',      'Breithorn Westgipfel / Breithorn Occidentale',
 'Breithorn', 'Pennine Alps',
 4164, 45.941111, 7.747222, 438, 4.2,
 1813, 'Maynard, Couttet, Gras, Erin, Erin',
 'VS/IT', TRUE, 39, 163.4,
 'Most accessible 4000m peak; reachable by cable car from Zermatt'),

('Breithorn Mittelgipfel', 'Breithorn Centrale / Breithorn Central',
 'Breithorn', 'Pennine Alps',
 4160, 45.938889, 7.756389, 73, 0.7,
 1813, 'Part of first Breithorn traverse',
 'VS/IT', TRUE, 41, 163.3, NULL),

('Breithorn Zwillinge West', 'Breithornzwillinge / Gemelli Occidentale',
 'Breithorn', 'Pennine Alps',
 4139, 45.937222, 7.767222, 120, 0.8,
 NULL, NULL,
 'VS/IT', TRUE, 43, 163.0, NULL),

('Breithorn Gendarm',   'Breithorn Zwillinge Ost / Gemello Est',
 'Breithorn', 'Pennine Alps',
 4106, 45.935833, 7.770556, 36, 0.3,
 NULL, NULL,
 'VS/IT', TRUE, 51, 163.0, NULL),

('Breithorn Roccia Nera', 'Schwarzfluh / Roche Noire',
 'Breithorn', 'Pennine Alps',
 4075, 45.932500, 7.775278, 30, 0.4,
 NULL, 'Part of Breithorn ridge traverse',
 'VS/IT', TRUE, 57, 163.2, NULL),

-- GRAND COMBIN MASSIF
('Combin de Grafeneire', 'Grand Combin de Grafeneire',
 'Grand Combin', 'Pennine Alps',
 4314, 45.937500, 7.299167, 1512, 26.5,
 1857, 'Bruchez, B.Felley, M.Felley',
 'VS', TRUE, 20, 183.6, NULL),

('Combin de Valsorey',  'Grand Combin de Valsorey',
 'Grand Combin', 'Pennine Alps',
 4184, 45.938056, 7.290556, 57, 0.5,
 1872, 'Isler, Gillioz',
 'VS', TRUE, 36, 183.9, NULL),

('Combin de la Tsessette', 'Grand Combin de la Tsessette',
 'Grand Combin', 'Pennine Alps',
 4135, 45.942778, 7.310833, 57, 0.9,
 1894, 'Benecke, Cohen',
 'VS', TRUE, 44, 182.5, NULL),

-- BERNESE ALPS
('Finsteraarhorn',      NULL,
 'Finsteraarhorn', 'Bernese Alps',
 4274, 46.537472, 8.126028, 2279, 51.7,
 1812, 'Abbühl, Bortis, Volker (guides)',
 'BE/VS', TRUE, 23, 91.9,
 'Highest peak in the Bernese Alps; 2nd most prominent Alpine peak'),

('Aletschhorn',         NULL,
 'Aletschhorn', 'Bernese Alps',
 4193, 46.465100, 7.993661, 1043, 13.5,
 1859, 'Tuckett, Bennen, Bohren, Tairraz',
 'VS/BE', TRUE, 34, 104.4, NULL),

('Jungfrau',            NULL,
 'Jungfrau', 'Bernese Alps',
 4158, 46.536806, 7.962639, 694, 8.3,
 1811, 'J.R.Meyer, H.Meyer, Volker, Bortis',
 'BE/VS', TRUE, 40, 99.7,
 'Famous tourist destination; railway station at 3454 m (Jungfraujoch)'),

('Moench',              'Mönch / Moine',
 'Jungfrau', 'Bernese Alps',
 4107, 46.558333, 7.997222, 591, 3.5,
 1857, 'Porges, C.Almer, C.Kaufmann, U.Kaufmann',
 'BE/VS', TRUE, 48, 96.2, NULL),

('Schreckhorn',         'Corne du Diable',
 'Schreckhorn', 'Bernese Alps',
 4078, 46.589972, 8.118139, 795, 5.9,
 1861, 'Stephen, U.Kaufmann, P.Michel, C.Michel',
 'BE', TRUE, 56, 87.6, NULL),

('Gross Fiescherhorn',  'Grand Fiescherhorn',
 'Fiescherhorn', 'Bernese Alps',
 4049, 46.551389, 8.061111, 396, 4.7,
 1862, 'Moore, George, Kaufmann, Almer',
 'BE/VS', TRUE, 65, 93.6, NULL),

('Gruenhorn',           'Grosses Grünhorn / Grand Grünhorn',
 'Fiescherhorn', 'Bernese Alps',
 4044, 46.531889, 8.077722, 303, 2.5,
 1865, 'von Fellenberg, Michel, Egger, Inaebnit',
 'BE/VS', TRUE, 69, 94.6, NULL),

('Lauteraarhorn',       NULL,
 'Fiescherhorn', 'Bernese Alps',
 4042, 46.583389, 8.128417, 128, 1.0,
 1842, 'Desor, Escher von der Linth, Girard, Bannholzer, Leuthold',
 'BE/VS', TRUE, 70, 87.7, NULL),

('Hinteres Fiescherhorn', 'Petit Fiescherhorn',
 'Fiescherhorn', 'Bernese Alps',
 4025, 46.546389, 8.067778, 102, 0.7,
 1885, 'Lammer, Lorria',
 'BE/VS', TRUE, 74, 93.8, NULL),

-- BERNINA GROUP (Graubünden)
('Piz Bernina',         'Pizzo Bernina',
 'Bernina', 'Rhaetian Alps',
 4049, 46.382222, 9.908056, 2236, 138.0,
 1850, 'Coaz, J.R.Tscharner, L.R.Tscharner',
 'GR', TRUE, 66, 122.5,
 'Highest peak in Graubünden; easternmost 4000m peak in the Alps; most isolated Swiss 4000er');

-- ============================================================
-- USEFUL VIEWS
-- ============================================================

CREATE VIEW peaks_by_elevation AS
    SELECT id, name, massif, range, elevation_m, cantons, dist_richterswil_km
    FROM swiss_4000ers
    ORDER BY elevation_m DESC;

CREATE VIEW peaks_by_distance AS
    SELECT id, name, massif, elevation_m, cantons, dist_richterswil_km
    FROM swiss_4000ers
    ORDER BY dist_richterswil_km ASC;

CREATE VIEW peaks_by_prominence AS
    SELECT id, name, massif, elevation_m, prominence_m, cantons
    FROM swiss_4000ers
    ORDER BY prominence_m DESC;


-- ============================================================
-- TRAILHEAD DATA (source: SAC Tourenportal)
-- ============================================================
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt, walk to Monte Rosa Hut (2883m). Normal route ascends via Grenzgletscher.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=1;
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt; approach via Monte Rosa Hut (2883m). Ascends NE ridge from Silbersattel.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=2;
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt; via Monte Rosa Hut (2883m), Grenzgletscher to Grenzsattel, then south ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=3;
UPDATE swiss_4000ers SET trailhead_name='Indren cable car (3275m), Gressoney/Alagna', trailhead_description='Cable car to Indren (3275m); overnight at Rifugio Gnifetti (3647m); via Lys Glacier to Capanna Margherita.', trailhead_lat=45.8759, trailhead_lon=7.8682 WHERE id=4;
UPDATE swiss_4000ers SET trailhead_name='Indren cable car (3275m), Gressoney/Alagna', trailhead_description='Cable car to Indren (3275m), overnight Rifugio Gnifetti (3647m); Lys Glacier ridge via Signalkuppe.', trailhead_lat=45.8759, trailhead_lon=7.8682 WHERE id=5;
UPDATE swiss_4000ers SET trailhead_name='Indren cable car (3275m), Gressoney/Alagna', trailhead_description='Cable car to Indren (3275m), overnight Rifugio Gnifetti (3647m); Lys Glacier ridge through Signalkuppe and Parrotspitze.', trailhead_lat=45.8759, trailhead_lon=7.8682 WHERE id=6;
UPDATE swiss_4000ers SET trailhead_name='Indren cable car (3275m), Gressoney/Alagna', trailhead_description='Cable car to Indren (3275m), overnight Rifugio Gnifetti (3647m); via Lys Glacier col and steep snow/rock flank.', trailhead_lat=45.8759, trailhead_lon=7.8682 WHERE id=7;
UPDATE swiss_4000ers SET trailhead_name='Indren cable car (3275m), Gressoney/Alagna', trailhead_description='Cable car to Indren (3275m), overnight Rifugio Gnifetti (3647m); Lys Glacier to east ridge.', trailhead_lat=45.8759, trailhead_lon=7.8682 WHERE id=8;
UPDATE swiss_4000ers SET trailhead_name='Randa railway station (1407m)', trailhead_description='Train to Randa (Brig-Zermatt line); trail 1500m to Dom Hut (2940m); normal route via Festi Glacier to NW ridge.', trailhead_lat=46.1006, trailhead_lon=7.7839 WHERE id=9;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m) and Mischabeljoch bivouac; SE ridge from Mischabeljoch.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=10;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m); NE Windgrat ridge over Hohbalm Glacier.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=11;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m); north ridge from Nadelhorn col.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=12;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m); traverse from Nadelhorn via Nadelgrat ridge.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=13;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m); Nadelgrat from Stecknadelhorn.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=14;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee (1800m)', trailhead_description='Drive or bus to Saas-Fee; trail to Mischabel Hut (3340m); Nadelgrat traverse from Hohberghorn.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=15;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee, Felskinn cable car (2989m)', trailhead_description='Felskinn cable car from Saas-Fee; via Alphubeljoch from Fee Glacier, ascending broad NW snow flank.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=16;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee, Felskinn cable car (2989m)', trailhead_description='Felskinn cable car from Saas-Fee; via Britannia Hut (3030m) and Allalin Glacier, NE ridge.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=17;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee, Felskinn cable car (2989m)', trailhead_description='Felskinn cable car from Saas-Fee; via Britannia Hut (3030m), Allalin Glacier to Adlerpass, then NW ridge.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=18;
UPDATE swiss_4000ers SET trailhead_name='Saas-Fee, Metro Alpin Mittelallalin (3456m)', trailhead_description='Felskinn cable car then Metro Alpin to Mittelallalin (3456m); straightforward snow ascent ~500m to summit.', trailhead_lat=46.1117, trailhead_lon=7.9337 WHERE id=19;
UPDATE swiss_4000ers SET trailhead_name='Randa railway station (1407m)', trailhead_description='Train to Randa; trail to Weisshorn Hut (2932m); normal route: long east ridge, exposed but non-technical.', trailhead_lat=46.1006, trailhead_lon=7.7839 WHERE id=20;
UPDATE swiss_4000ers SET trailhead_name='Zinal village parking (1675m)', trailhead_description='Drive or bus to Zinal; trail 1580m to Cabane de Tracuit (3256m); NW glacier flank on straightforward snow.', trailhead_lat=46.1363, trailhead_lon=7.6268 WHERE id=21;
UPDATE swiss_4000ers SET trailhead_name='Ferpecle, Les Salay parking (1767m)', trailhead_description='Drive to end of Ferpecle road (Les Salay, 1767m); via Bricola alp to Cabane de la Dent Blanche (3507m); south ridge.', trailhead_lat=46.0833, trailhead_lon=7.5667 WHERE id=22;
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt; approach via Rothorn Hut (3198m); SW ridge via Rothorn Glacier and Biner-Platte slab.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=23;
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt; via Trift valley to Arben Bivouac (3224m); ascends Trift Glacier and NE ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=24;
UPDATE swiss_4000ers SET trailhead_name='Saas-Grund, Kreuzboden gondola (1559m)', trailhead_description='Drive or bus to Saas-Grund; gondola to Kreuzboden (2397m), walk to Weissmies Hut (2726m); NW snow flank.', trailhead_lat=46.1333, trailhead_lon=7.9333 WHERE id=25;
UPDATE swiss_4000ers SET trailhead_name='Saas-Grund, Kreuzboden gondola (1559m)', trailhead_description='Drive or bus to Saas-Grund; gondola to Kreuzboden (2397m) or Hohsaas; WSW ridge from Weissmies Hut area.', trailhead_lat=46.1333, trailhead_lon=7.9333 WHERE id=26;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); Breithorn plateau and Grenzgletscher to Lisjoch, then east ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=27;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); Breithorn plateau and Grenzgletscher to Lisjoch; traverse full Lyskamm ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=28;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Schwarzsee cable car (2583m)', trailhead_description='Train to Zermatt then cable car to Schwarzsee (2583m); Hornli Ridge route to Hornlihutte (3260m), up NE ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=29;
UPDATE swiss_4000ers SET trailhead_name='Zermatt (1608m)', trailhead_description='Train to Zermatt; via Zmutt valley to Schonbielhütte (2694m); north glacier and NW ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=30;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); Breithorn plateau to Zwillingsjoch, then WNW snow flank.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=31;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); descend to Zwillingsjoch; SE snow and rock ridge with one fixed rope.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=32;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); traverse Breithorn plateau and ascend 35 deg west summit snow flank.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=33;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); traverse east from West Summit along Breithorn ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=34;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); full Breithorn traverse east past Mittelgipfel; technical east ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=35;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); Gendarm rock pinnacle during full Breithorn traverse after the Twins.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=36;
UPDATE swiss_4000ers SET trailhead_name='Zermatt, Klein Matterhorn cable car (3883m)', trailhead_description='Cable car to Klein Matterhorn (3883m); easternmost Breithorn summit, traversing the full east ridge.', trailhead_lat=46.0207, trailhead_lon=7.7491 WHERE id=37;
UPDATE swiss_4000ers SET trailhead_name='Bourg-Saint-Pierre (1632m)', trailhead_description='Drive to Bourg-Saint-Pierre; trail up Valsorey valley to Cabane de Valsorey (3037m); Meitin Ridge and Corridor snow slope.', trailhead_lat=45.9417, trailhead_lon=7.2083 WHERE id=38;
UPDATE swiss_4000ers SET trailhead_name='Bourg-Saint-Pierre (1632m)', trailhead_description='Drive to Bourg-Saint-Pierre; trail to Cabane de Valsorey (3037m); Meitin Ridge to Valsorey summit.', trailhead_lat=45.9417, trailhead_lon=7.2083 WHERE id=39;
UPDATE swiss_4000ers SET trailhead_name='Bourg-Saint-Pierre (1632m)', trailhead_description='Drive to Bourg-Saint-Pierre; trail to Cabane de Valsorey (3037m); traverse from Grafeneire across Combin plateau.', trailhead_lat=45.9417, trailhead_lon=7.2083 WHERE id=40;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; glacier traverse via Konkordiaplatz and Gruenhornluecke to Finsteraarhornhuette (3048m); NE ridge.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=41;
UPDATE swiss_4000ers SET trailhead_name='Fiesch, cable car to Fiescheralp (2212m)', trailhead_description='Train to Fiesch; cable car to Fiescheralp (2212m); glacier approach via Hollandia Hut (3238m); SW ridge.', trailhead_lat=46.3983, trailhead_lon=8.1308 WHERE id=42;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; descend to Jungfraufirn, ascend via Rottalsattel — straightforward glacier route.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=43;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; short glacier walk to Moenchsjochhuette; SE ridge — classic introductory alpine climb.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=44;
UPDATE swiss_4000ers SET trailhead_name='Grindelwald, Pfingstegg cable car (1391m)', trailhead_description='Cable car from Grindelwald to Pfingstegg (1391m); trail 4-5h to Schreckhornhuette (2527m); SW ridge.', trailhead_lat=46.6241, trailhead_lon=8.0414 WHERE id=45;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; Ewigschneefeld glacier approach; west ridge from Fieschersattel.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=46;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; via Konkordiaplatz and Ewigschneefeld; Gruenhornluecke and NW ridge.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=47;
UPDATE swiss_4000ers SET trailhead_name='Grindelwald, Pfingstegg cable car (1391m)', trailhead_description='Cable car to Pfingstegg (1391m); trail to Schreckhornhuette (2527m); via Schreckhorn connection or Lauteraargletscher.', trailhead_lat=46.6241, trailhead_lon=8.0414 WHERE id=48;
UPDATE swiss_4000ers SET trailhead_name='Jungfraujoch railway station (3454m)', trailhead_description='Train to Jungfraujoch; Ewigschneefeld approach; climbed together with Gross Fiescherhorn via Fieschersattel.', trailhead_lat=46.5473, trailhead_lon=7.9853 WHERE id=49;
UPDATE swiss_4000ers SET trailhead_name='Diavolezza cable car / Bernina halt (2093m)', trailhead_description='Train to Diavolezza halt, cable car to Diavolezza (2978m); Spallagrat route via Pers Glacier, Rifugio Marco e Rosa (3609m) and Spallagrat ridge.', trailhead_lat=46.4106, trailhead_lon=9.9728 WHERE id=50;
