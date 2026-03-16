PGM
DCL VAR(&DATA) TYPE(*CHAR) LEN(256)

CHGVAR &DATA +
('000101JOHN SMITH                   IT                         john.smith@abc.com        9876543210A')

SNDDTAQ DTAQ(HEXACAB/EMPDTAQ) DTAQDATA(&DATA)

ENDPGM
