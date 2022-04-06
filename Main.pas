program WriteBinaryData;

///if free pascal / если фри паскаль раскомментить
//uses windows, sysutils, classes;

const
  C_FNAME = '..\NoExam\Resources\';

var
  tf: TextFile;
  s, all: string;
  i : integer;

procedure Ex(p: string);
begin
  Assign(tf, C_FNAME+p);

  writeln('Read: ', p);
  reset(tf);
  while not eof(tf) do
  begin
    readln(tf, s);
    for var i := 1 to Length(s) do
    begin
      if (s[i] <> '.') then
        begin
//          all := all + ord(s[i]), ' ';
          write(ord(s[i]), ' ')
        end
      else writeln();
      end;
  end;
  Close(tf);
  writeln();
end;

begin

  Ex('dataANSI.txt');
  Ex('dataDOS.txt');
  Ex('dataUTF8.txt');
  Ex('dataUTF16LE.txt');

  readln;
end.
