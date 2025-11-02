This project mimics the behaviour of the Mengenlehreuhr in Berlin, aka Berlin Clock.

I chose to go the KISS way instead of some fancy Erlang/Elixir/Phoenix approach and hope you like it.

It is supposed to be a 2 tier solution.
A backend converts the current time into the format base 5.
A frontend takes the data and displays it to the user.

To get results take the following steps:
- start "bc.bat" on a windows pc.
- after it produced a file called "berlinclock.dat" start the accompanying HTML file.
- click the button to select the "berlinclock.dat" as input

The batch file "bc.bat" loops indefinitely and writes every second to a text file called "berlinclock.dat". See "bc.bat" for detailed description of content.
The HTML page lets the user choose the output file of "bc.bat" and displays the data using Javascript to determine which lamps should be on or off.
This techniques do not allow continous reloading of the dat file but you will get the picture.
Please understand this project as a simple proof-of-concept, nothing else.
Of course there are tons of possibilities to improve this solution and would i get paid for it then i would do it of course.

There is no copyright whatsoever, consider it to be under WTFPL license.
