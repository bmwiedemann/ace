#############################################################################
####
##
#W  options.gd              ACE Share Package                     Greg Gamble
##
##  This file declares functions and records for manipulating ACE options.
##    
#H  @(#)$Id$
##
#Y  Copyright (C) 2000  Centre for Discrete Mathematics and Computing
#Y                      Department of Computer Science & Electrical Eng.
#Y                      University of Queensland, Australia.
##
Revision.options_gd :=
    "@(#)$Id$";


#############################################################################
##
#D  Declare variables.
##

DeclareGlobalVariable("KnownACEOptions",
  Concatenation([
    "A record whose fields are the known ACE options. The value of\n",
    "each record field (option) is a list [ leastlength, listorfn ],\n",
    "where leastlength an integer specifying the least length of an\n",
    "abbreviation of the option and listorfn is either a list of\n",
    "allowed values or a function that can be used to test that the\n",
    "value of an option is valid."])
  );

DeclareGlobalVariable("NonACEbinOptions",
  "A list of known ACE (interface) options that are not ACE binary options"
  );

DeclareGlobalVariable("ACE_ERRORS",
  "A record of ACE (interface) error messages"
  );

#############################################################################
##
#D  Declare functions.
##

DeclareGlobalFunction("IS_INC_POS_INT_LIST");
DeclareGlobalFunction("ACE_OPTIONS");
DeclareGlobalFunction("ACE_OPT_NAMES");
DeclareGlobalFunction("MATCHES_KNOWN_ACE_OPT_NAME");
DeclareGlobalFunction("FULL_ACE_OPT_NAME");
DeclareGlobalFunction("VALUE_ACE_OPTION");
DeclareGlobalFunction("ACE_WORDS");
DeclareGlobalFunction("PROCESS_ACE_OPTIONS");
DeclareGlobalFunction("CurrentACEOptions");
DeclareGlobalFunction("SetACEOptions");
DeclareGlobalFunction("FlushOptionsStack");
DeclareGlobalFunction("SET_ACE_OPTION");

#E  options.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here 
