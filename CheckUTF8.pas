﻿///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit CheckUTF8;

interface

const
  UTF8_ARR: array of integer = (1072, 1073, 1074, 1075, 1076, 1077, 1105, 1078,
   1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 
   1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1040, 
   1041, 1042, 1043, 1044, 1045, 1025, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 
   1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 
   1066, 1067, 1068, 1069, 1070, 1071);

function IsUTF8(const arr: array of integer): boolean;

implementation

function IsUTF8(const arr: array of integer): boolean;
var
  i, j: integer;
begin
  i := 0;
  while (i < length(arr) - 1) do
  begin
    inc(i);
    j := 0;
    while (j < length(UTF8_ARR)) do
    begin
      if (arr[i] = UTF8_ARR[j]) then 
      begin
        IsUTF8 := true;
        exit;
      end;
      inc(j);
    end;
  end;
  
  IsUTF8 := false;
end;
end.

