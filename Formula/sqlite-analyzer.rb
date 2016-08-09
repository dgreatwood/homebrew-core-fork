class SqliteAnalyzer < Formula
  desc "Analyze how space is allocated inside an SQLite file"
  homepage "https://www.sqlite.org/"
  url "https://sqlite.org/2016/sqlite-src-3140000.zip"
  version "3.14.0"
  sha256 "97d5735dddfb74598a0694a0252e5b19caeac49f2fed30181598d2243b619abb"

  bottle do
    cellar :any_skip_relocation
    sha256 "6bd1df738dba17cfa03dad4c5d1b4eb26479e210dbeb3c30acce0f19808881b6" => :el_capitan
    sha256 "9eb7d3df9680d81826da6e39041d28abeba247cbb084a8690524485d34a934c7" => :yosemite
    sha256 "5092ae2ccce00d9dbf4b8d33a318883054eafd904d55e0ba8ef6a415f7b31497" => :mavericks
    sha256 "abaf9bc21f00454ee737716345f633383beb92bda83f45c27420eebab3d4d5b7" => :mountain_lion
  end

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "sqlite3_analyzer"
    bin.install "sqlite3_analyzer"
  end

  test do
    dbpath = testpath/"school.sqlite"
    sqlpath = testpath/"school.sql"
    sqlpath.write <<-EOS.undent
      create table students (name text, age integer);
      insert into students (name, age) values ('Bob', 14);
      insert into students (name, age) values ('Sue', 12);
      insert into students (name, age) values ('Tim', 13);
    EOS
    system "/usr/bin/sqlite3 #{dbpath} < #{sqlpath}"
    system "#{bin}/sqlite3_analyzer", dbpath
  end
end
