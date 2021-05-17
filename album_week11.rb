require "./input_functions"
# Use the code from previous task to complete this:


module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
# NB: you will need to add tracks to the following and the initialize()
	attr_accessor :title, :artist, :genre, :tracks, :plocation

# complete the missing code:
	def initialize (atitle, aartist, agenre, atrk, ploc)
		# insert lines here
		@title = atitle
		@artist = aartist
		@genre = agenre
		@tracks = atrk
		@plocation = ploc
	end
end

class Track
	attr_accessor :title, :location

	def initialize (tname, tloc)
		@title = tname
		@location = tloc
	end
end

# Reads in and returns a single track from the given file

def read_track (music_file)
	# fill in the missing code
	mytrack_title = music_file.gets.chomp
	mytrack_location = music_file.gets.chomp
	mytrack = Track.new(mytrack_title, mytrack_location)
	return mytrack
end

# Returns an array of tracks read from the given file

def read_tracks (music_file)
	tracks = Array.new
	count = music_file.gets.chomp.to_i

	# Put a while loop here which increments an index to read the tracks
	x=0
	while x < count
		tracks << read_track(music_file)
		
		x+=1
	end

	return tracks
end

# Takes an array of tracks and prints them to the terminal

def print_tracks (tracks)
	# print all the tracks use: tracks[x] to access each track.
	for i in 0..tracks.length-1
		puts "			" + tracks[i].title
		puts "			" + tracks[i].location
	end
end

# Reads in and returns a single album from the given file, with all its tracks

def read_album music_file

	# read in all the Album's fields/attributes including all the tracks
	# complete the missing code
	album_title = music_file.gets.chomp
	album_artist = music_file.gets.chomp
	album_location = music_file.gets.chomp
	album_genre = music_file.gets.chomp
	tracks = read_tracks (music_file)
	album = Album.new(album_title, album_artist, album_genre, tracks, album_location)
	return album
end


# Takes a single album and prints it to the terminal along with all its tracks
def print_album (album)
	#length = album.length-1
  # print out all the albums fields/attributes
  # Complete the missing code.
	puts "			Title is --> " + album.title
	puts "			Artist is -> " + album.artist
	puts "			Genre is --> " + album.genre.to_s
	puts "			Location --> " + album.plocation.to_s
	puts "			" + $genre_names[album.genre.to_i]
	print_tracks (album.tracks)
	puts ""
	# print out the tracks

end

# Takes a single track and prints it to the terminal
def print_track track
	puts('Track title is: ' + track.title)
	puts('Track file location is: ' + track.location)
end

# Reads in an album from a file and then print the album to the terminal

def main
	album_array = Array.new()
	run = true
	while run
		puts "1. Read Albums"
		puts "2. Display Albums"
		puts "3. Update Existing Albums"
		puts "4. Exit Application"
		option = read_integer_in_range("Please enter your selection",1,4)

		if option == 1
			puts "Enter name of text file:"
			tname = gets.chomp

			music_file = File.new(tname, "r")
			no_of_album = music_file.gets.chomp.to_i
			for x in 0..no_of_album-1
				album_array << read_album(music_file)
			end
			
			music_file.close()
			puts "			========================"
			puts "			|    Reading album...  |"
			puts "			|    Successful!       |"
			puts "			========================"
			puts ""
		elsif option == 2
			
			#music_file = File.new(tname, "r")
			#no_of_album = music_file.gets.chomp.to_i

			for x in 0..album_array.length-1
				puts ""
				puts "			==========[#{x+1}]==========="
				print_album(album_array[x])
			end
			
			puts ""
			puts ""
		
		elsif option == 3

			#music_file = File.new("albums.txt", "r")
			#no_of_album = music_file.gets.chomp.to_i

			for x in 0..no_of_album-1
				puts "ALBUM " + (x+1).to_s + ":"
				puts album_array[x].title
			end

			selected = read_integer_in_range("Select album number:", 1, no_of_album)
			
			puts "Enter your customized title:"
			answer = gets.chomp
			album_array[selected-1].title = answer
		
		elsif option == 4
			music_file = File.new(tname, "w")
			#no_of_album = music_file.gets.chomp.to_i
			music_file.puts no_of_album.to_s
			for x in 0..no_of_album-1
				music_file.puts album_array[x].title
				music_file.puts album_array[x].artist
				music_file.puts album_array[x].plocation
				music_file.puts album_array[x].genre
				music_file.puts album_array[x].tracks.length.to_s
				for y in 0..album_array[x].tracks.length-1
					music_file.puts album_array[x].tracks[y].title
					music_file.puts album_array[x].tracks[y].location
				end
			end
			run = false
		end
	end
end

main
