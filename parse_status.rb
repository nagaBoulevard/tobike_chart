#!/usr/bin/ruby

handle = $stdin.read;

handle.each_line do |line|
	line = line.split "\t";
	empty = line[2].scan(/0/).length;
	active = line[2].scan(/4/).length;
	inactive = line[2].scan(/1|5/).length;
	puts "#{Time.now.strftime "%Y_%m_%d_%H_%M"}\t#{line.join("\t").strip}\t#{active}\t#{empty}\t#{inactive}"
end
