require 'formula'

class Cassandra < Formula
  url 'http://www.apache.org/dyn/closer.cgi?path=cassandra/0.8.4/apache-cassandra-0.8.4-bin.tar.gz'
  homepage 'http://cassandra.apache.org'
  md5 'e3cf1896d65ede37aebabe5af4569033'

  def install
    (var+"lib/cassandra").mkpath
    (var+"log/cassandra").mkpath
    (etc+"cassandra").mkpath

    inreplace "conf/cassandra.yaml", "/var/lib/cassandra", "#{var}/lib/cassandra"
    inreplace "conf/log4j-server.properties", "/var/log/cassandra", "#{var}/log/cassandra"

    inreplace "conf/cassandra-env.sh" do |s|
      s.gsub! "/lib/", "/"
    end

    inreplace "bin/cassandra.in.sh" do |s|
      s.gsub! "CASSANDRA_HOME=`dirname $0`/..", "CASSANDRA_HOME=#{prefix}"
      # Store configs in etc, outside of keg
      s.gsub! "CASSANDRA_CONF=$CASSANDRA_HOME/conf", "CASSANDRA_CONF=#{etc}/cassandra"
      # Jars installed to prefix, no longer in a lib folder
      s.gsub! "$CASSANDRA_HOME/lib/*.jar", "$CASSANDRA_HOME/*.jar"
    end

    rm Dir["bin/*.bat"]

    (etc+"cassandra").install Dir["conf/*"]
    prefix.install Dir["*.txt"] + Dir["{bin,interface,javadoc,lib/licenses}"]
    prefix.install Dir["lib/*.jar"]
  end
end
