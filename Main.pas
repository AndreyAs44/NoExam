program WriteBinaryData;

///if free pascal / если фри паскаль раскомментить
uses windows, sysutils, classes;

const
  IN_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\In_Files\';
  ///console file / файл того что в консоли
  OUT_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\Out_Files\Out1.txt';

var
  //text var.
  tfIn, tfOut, tf: TextFile;
  //other var.
  s: string;
  i: integer;

procedure ResetFile(s: string);
begin
  Assign(tf, s);
  Rewrite(tf);
  Close(tf);
end;

procedure Print(s: string);
begin
  Assign(tfOut, OUT_PATH);
  Append(tfOut);
  Write(s);
  Write(tfOut, s);
  Close(tfOut);
end;

procedure Println(s: string);
begin
  Assign(tfOut, OUT_PATH);
  Append(tfOut);
  Writeln(s);
  Writeln(tfOut, s);
  Close(tfOut);
end;

procedure FileToByte(name: string);
begin
  Assign(tf, IN_PATH + name);
  
  Println('Read: ' + IN_PATH + name);
  reset(tf);
  while not eof(tf) do
  begin
    readln(tf, s);
    i := 1;
    while (i < Length(s)) do
    begin
      Inc(i);
      
      if (s[i] <> '.') then
      begin
        Print(IntToStr(ord(s[i])) + ' ');
      end
      else Println('');
      
    end;
  end;
  
  Close(tf);
  Println('');
end;

begin
  ResetFile(OUT_PATH);
  
  FileToByte('dataANSI.txt');
  FileToByte('dataDOS.txt');
  FileToByte('dataUTF8.txt');
  FileToByte('dataUTF16LE.txt');
  
  readln;
end.