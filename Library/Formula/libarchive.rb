require 'formula'

class Libarchive <Formula
  url 'http://libarchive.googlecode.com/files/libarchive-2.8.4.tar.gz'
  homepage 'http://code.google.com/p/libarchive/'
  md5 '83b237a542f27969a8d68ac217dc3796'

  # depends_on 'cmake'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
