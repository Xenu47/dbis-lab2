INSERT INTO locations (territory, area, region, ter_type)
SELECT DISTINCT TERNAME, AREANAME, REGNAME, TERTYPENAME
FROM zno_opendata;

INSERT INTO locations (territory, area, region)
SELECT DISTINCT EORegName, EOAreaName, EOTerName
FROM zno_opendata
WHERE EORegName IS NOT NULL
EXCEPT SELECT territory, area, region
FROM locations;



INSERT INTO school (school_name, school_type, school_region, school_area, school_territory, school_parent)
SELECT DISTINCT on (EONAME) EONAME, EOTYPENAME, EORegName, EOAreaName, EOTerName, EOParent
FROM zno_opendata
WHERE EONAME IS NOT NULL;

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (UkrPTName) UkrPTName, UkrPTRegName, UkrPTAreaName, UkrPTTerName
FROM zno_opendata
WHERE UkrPTName IS NOT NULL AND UkrPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (histPTName) histPTName, histPTRegName, histPTAreaName, histPTTerName
FROM zno_opendata
WHERE histPTName IS NOT NULL AND histPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (mathPTName) mathPTName, mathPTRegName, mathPTAreaName, mathPTTerName
FROM zno_opendata
WHERE mathPTName IS NOT NULL AND mathPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (physPTName) physPTName, physPTRegName, physPTAreaName, physPTTerName
FROM zno_opendata
WHERE physPTName IS NOT NULL AND physPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (chemPTName) chemPTName, chemPTRegName, chemPTAreaName, chemPTTerName
FROM zno_opendata
WHERE chemPTName IS NOT NULL AND chemPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (bioPTName) bioPTName, bioPTRegName, bioPTAreaName, bioPTTerName
FROM zno_opendata
WHERE bioPTName IS NOT NULL AND bioPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (geoPTName) geoPTName, geoPTRegName, geoPTAreaName, geoPTTerName
FROM zno_opendata
WHERE geoPTName IS NOT NULL AND geoPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (engPTName) engPTName, engPTRegName, engPTAreaName, engPTTerName
FROM zno_opendata
WHERE engPTName IS NOT NULL AND engPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (fraPTName) fraPTName, fraPTRegName, fraPTAreaName, fraPTTerName
FROM zno_opendata
WHERE fraPTName IS NOT NULL AND fraPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (deuPTName) deuPTName, deuPTRegName, deuPTAreaName, deuPTTerName
FROM zno_opendata
WHERE deuPTName IS NOT NULL AND deuPTName NOT IN (SELECT school_name FROM school);

INSERT INTO school (school_name, school_region, school_area, school_territory)
SELECT DISTINCT on (spaPTName) spaPTName, spaPTRegName, spaPTAreaName, spaPTTerName
FROM zno_opendata
WHERE spaPTName IS NOT NULL AND spaPTName NOT IN (SELECT school_name FROM school);



INSERT INTO student ("OUTID", birth, sex, territory, area, region, status, class_profile, class_lang, school_name)
SELECT DISTINCT on (OUTID) OUTID, Birth, SEXTYPENAME, TERNAME, AREANAME, REGNAME, REGTYPENAME, ClassProfileNAME, ClassLangName, EONAME
FROM zno_opendata;



INSERT INTO results ("OUTID", subject_year, subject_name, subject_test_status, subject_ball100, subject_ball12, subject_ball, subject_adapt_scale, school_name)
SELECT DISTINCT OUTID, "year", UkrTest, UkrTestStatus, UkrBall100, UkrBall12, UkrBall, UkrAdaptScale, UkrPTName
FROM zno_opendata
WHERE UkrTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", histTest, HistLang, histTestStatus, histBall100, histBall12, histBall, histPTName
FROM zno_opendata
WHERE histTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", mathTest, mathLang, mathTestStatus, mathBall100, mathBall12, mathBall, mathPTName
FROM zno_opendata
WHERE mathTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", physTest, physLang, physTestStatus, physBall100, physBall12, physBall, physPTName
FROM zno_opendata
WHERE physTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", chemTest, chemLang, chemTestStatus, chemBall100, chemBall12, chemBall, chemPTName
FROM zno_opendata
WHERE chemTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", bioTest, bioLang, bioTestStatus, bioBall100, bioBall12, bioBall, bioPTName
FROM zno_opendata
WHERE bioTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_lang, subject_test_status, subject_ball100, subject_ball12, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", geoTest, geoLang, geoTestStatus, geoBall100, geoBall12, geoBall, geoPTName
FROM zno_opendata
WHERE geoTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_test_status, subject_ball100, subject_ball12, subject_dpa, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", engTest, engTestStatus, engBall100, engBall12, engDPALevel, engBall, engPTName
FROM zno_opendata
WHERE engTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_test_status, subject_ball100, subject_ball12, subject_dpa, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", fraTest, fraTestStatus, fraBall100, fraBall12, fraDPALevel, fraBall, fraPTName
FROM zno_opendata
WHERE fraTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_test_status, subject_ball100, subject_ball12, subject_dpa, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", deuTest, deuTestStatus, deuBall100, deuBall12, deuDPALevel, deuBall, deuPTName
FROM zno_opendata
WHERE deuTest IS NOT NULL;

INSERT INTO results ("OUTID", subject_year, subject_name, subject_test_status, subject_ball100, subject_ball12, subject_dpa, subject_ball, school_name)
SELECT DISTINCT OUTID, "year", spaTest, spaTestStatus, spaBall100, spaBall12, spaDPALevel, spaBall, spaPTName
FROM zno_opendata
WHERE spaTest IS NOT NULL;
