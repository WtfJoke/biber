# -*- cperl -*-
use strict;
use warnings;
use utf8;
no warnings 'utf8';

use Test::More tests => 3;
use Test::Differences;
unified_diff;

use Biber;
use Biber::Utils;
use Biber::Output::bbl;
use Log::Log4perl;
chdir("t/tdata");

my $biber = Biber->new(noconf => 1);
my $LEVEL = 'ERROR';
my $l4pconf = qq|
    log4perl.category.main                             = $LEVEL, Screen
    log4perl.category.screen                           = $LEVEL, Screen
    log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.utf8                      = 1
    log4perl.appender.Screen.Threshold                 = $LEVEL
    log4perl.appender.Screen.stderr                    = 0
    log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::SimpleLayout
|;
Log::Log4perl->init(\$l4pconf);

$biber->parse_ctrlfile('skipsg.bcf');
$biber->set_output_obj(Biber::Output::bbl->new());

# Options - we could set these in the control file but it's nice to see what we're
# relying on here for tests
Biber::Config->setblxoption(undef, 'skiplab', 'true');
Biber::Config->setblxoption(undef, 'skibib', 'true');
Biber::Config->setblxoption(undef, 'skipbiblist', 'true');

# Biber options
Biber::Config->setoption('sortlocale', 'en_GB.UTF-8');


my $S1 = q|    \entry{S1}{book}{skipbib=false,skipbiblist=false,skiplab=false}
      \name[default][en-us]{author}{2}{}{%
        {{hash=bd051a2f7a5f377e3a62581b0e0f8577}{%
           family={Doe},
           familyi={D\bibinitperiod},
           given={John},
           giveni={J\bibinitperiod}}}%
        {{hash=df9bf04cd41245e6d23ad7543e7fd90d}{%
           family={Abrahams},
           familyi={A\bibinitperiod},
           given={Albert},
           giveni={A\bibinitperiod}}}%
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \strng{namehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{fullhash}{8c77336299b25bdada7bf8038f46722f}
      \strng{bibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usbibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usfullhash}{8c77336299b25bdada7bf8038f46722f}
      \field{extraname}{1}
      \field{labelalpha}{DA95}
      \field{sortinit}{D}
      \strng{sortinithash}{c438b3d5d027251ba63f5ed538d98af5}
      \field{extradate}{1}
      \field{extradatescope}{labelyear}
      \field{labeldatesource}{year}
      \field{extraalpha}{1}
      \field[default][en-us]{labelnamesource}{author}
      \field[default][en-us]{labeltitlesource}{title}
      \field[default][en-us]{title}{Title 1}
      \field{year}{1995}
    \endentry
|;

my $S2 = q|    \entry{S2}{book}{skipbib=false,skiplab=false}
      \name[default][en-us]{author}{2}{}{%
        {{hash=bd051a2f7a5f377e3a62581b0e0f8577}{%
           family={Doe},
           familyi={D\bibinitperiod},
           given={John},
           giveni={J\bibinitperiod}}}%
        {{hash=df9bf04cd41245e6d23ad7543e7fd90d}{%
           family={Abrahams},
           familyi={A\bibinitperiod},
           given={Albert},
           giveni={A\bibinitperiod}}}%
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \strng{namehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{fullhash}{8c77336299b25bdada7bf8038f46722f}
      \strng{bibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usbibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usfullhash}{8c77336299b25bdada7bf8038f46722f}
      \field{extraname}{2}
      \field{labelalpha}{DA95}
      \field{sortinit}{D}
      \strng{sortinithash}{c438b3d5d027251ba63f5ed538d98af5}
      \field{extradate}{2}
      \field{extradatescope}{labelyear}
      \field{labeldatesource}{year}
      \field{extraalpha}{2}
      \field[default][en-us]{labelnamesource}{author}
      \field[default][en-us]{labeltitlesource}{title}
      \field[default][en-us]{title}{Title 2}
      \field{year}{1995}
    \endentry
|;

my $S3 = q|    \entry{S3}{book}{}
      \name[default][en-us]{author}{2}{}{%
        {{hash=bd051a2f7a5f377e3a62581b0e0f8577}{%
           family={Doe},
           familyi={D\bibinitperiod},
           given={John},
           giveni={J\bibinitperiod}}}%
        {{hash=df9bf04cd41245e6d23ad7543e7fd90d}{%
           family={Abrahams},
           familyi={A\bibinitperiod},
           given={Albert},
           giveni={A\bibinitperiod}}}%
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \strng{namehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{fullhash}{8c77336299b25bdada7bf8038f46722f}
      \strng{bibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usbibnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usnamehash}{8c77336299b25bdada7bf8038f46722f}
      \strng{authordefaulten-usfullhash}{8c77336299b25bdada7bf8038f46722f}
      \field{sortinit}{D}
      \strng{sortinithash}{c438b3d5d027251ba63f5ed538d98af5}
      \field{labeldatesource}{year}
      \field[default][en-us]{labelnamesource}{author}
      \field[default][en-us]{labeltitlesource}{title}
      \field[default][en-us]{title}{Title 3}
      \field{year}{1995}
    \endentry
|;

# Now generate the information
$biber->prepare;
my $out = $biber->get_output_obj;
my $section = $biber->sections->get_section(0);
my $main = $biber->datalists->get_list('custom/global//global/global');
# labels as per-entry dataonly=false
eq_or_diff( $out->get_output_entry('S1', $main), $S1, 'Global skips with entry override - 1') ;
# labels as per-entry skpiplab=false
eq_or_diff( $out->get_output_entry('S2', $main), $S2, 'Global skips with entry override - 2') ;
# no labels as global skip*=true
eq_or_diff( $out->get_output_entry('S3', $main), $S3, 'Global skips with entry override - 3') ;
