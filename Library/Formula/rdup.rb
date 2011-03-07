require 'formula'

class Rdup <Formula
  url 'http://www.miek.nl/projects/rdup/rdup-1.1.11.tar.bz2'
  homepage 'http://www.miek.nl/projects/rdup/'
  md5 'de5c8ff0dc1732f80692e46252025d07'

  depends_on 'libarchive'

  def install
    system "autoreconf"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    inreplace 'config.h' do |s|
      s.gsub! '/* #undef HAVE_DIRFD */', '#define HAVE_DIRFD 1'
    end
    system "make install"
  end
end