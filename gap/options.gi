#############################################################################
####
##
#W  options.gi              ACE Share Package                     Greg Gamble
##
##  This file installs functions and records for manipulating ACE options.
##    
#H  @(#)$Id$
##
#Y  Copyright (C) 2000  Centre for Discrete Mathematics and Computing
#Y                      Department of Computer Science & Electrical Eng.
#Y                      University of Queensland, Australia.
##
Revision.options_gi :=
    "@(#)$Id$";


#############################################################################
####
##
#V  KnownACEOptions . . . . . . record whose fields are the known ACE options
##  . . . . . . . . . . . . . . . . . .  each field is assigned a list of two 
##  . . . . . . . . . . . . . . . . . .  components:  [leastlength, listorfn]
##
##  The known ACE options  are the RecNames of KnownACEOptions.  The value of 
##  of each RecName is a list [ leastlength, listorfn ], where leastlength is
##  an integer specifying the least length of an abbreviation of the  RecName
##  that will match an ACE option,  and listorfn is either a list of  allowed 
##  values or a function that can be used to test that the value of an option 
##  is valid e.g. for the RecName "lookahead", we have knownOptions.lookahead 
##  equal to [ 4, [0..4] ] which indicates that "look", "looka", etc. are all 
##  valid abbreviations of the "lookahead" option,  and the values  that that 
##  option can take are in the (integer) range 0 to 4. 
##
##  If the allowed values listed for an option are 0 and 1,  then  false  and 
##  true are also permitted (we translate false and true to 0 and 1, respect-
##  ively when we call ACE). The empty string signifies that ACE  expects  no
##  value for that option.
##
##  Only single-word versions of options can be used by a user of ACE via the 
##  GAP interface e.g. "cc" is a synonym for "coset coincidence"  as  an  ACE
##  option,  but the latter,  being 2 words,  is  not available via  the  GAP 
##  interface.
##
##  The commented out options are known ACE options that probably  won't work
##  via the GAP interface ... if the user uses these  the  interface  program
##  CALL_ACE will complain: `unknown (possibly new) or bad'  but  still  pass 
##  these options to ACE ... at least the user will then know if ACE does not
##  respond as expected that the options should not be used.  We usually only 
##  warn that certain options might be bad, so that this interface has a good
##  chance of still being functional if new options are added to the ACE bin-
##  ary.
##
##  Some  options  are  `GAP-introduced'  i.e. technically they are  not  ACE 
##  options  ...  there is a comment beside such options;  and  they are also 
##  listed in NonACEbinOptions below.
##

InstallValue(KnownACEOptions, rec(
  # aceinfile, aceignore, aceignoreunknown, acenowarnings, silent (and 
  # further down: aceoutfile) are GAP-introduced options ... they  are
  # not ACE binary options.
  aceinfile := [5, IsString],
  aceignore := [5, x -> IsList(x) and ForAll(x, xi -> IsString(xi))],
  aceignoreunknown := [10, x -> IsList(x) and ForAll(x, xi -> IsString(xi))],
  acenowarnings := [6, [0,1]],
  silent := [6, [0,1]],
  #sg := [2, <word list>],
  #rl := [2, <relation list>],
  aep  := [3, [1..7]],
  #ai := [2, <filename>],
  ao   := [2, IsString],      # "ACEoutfile" is a GAP-introduced 
  aceoutfile := [4, IsString],# `synonym' for "ao"
  asis := [2, [0,1]],
  #begin := [3, [""]], start := [5, [""]], end := [3, [""]],
  #bye := [3, [""]], exit := [4, [""]], quit := [1, [""]],
  cc   := [2, x -> IsInt(x) and x > 1],
  cfactor := [1, IsInt],      # "cfactor" and "ct" are synonyms
  ct   := [2, IsInt],
  #check := [5, [""]], redo := [4, [""]],
  compaction := [3, [0..100]],
  #continue := [4, [""]],
  cycles := [2, [""]],
  dmode := [4, [0..4]],
  dsize := [4, x -> IsZero(x) or IsPosInt(x)],
  default := [3, [""]],
  ds := [2, IS_INC_POS_INT_LIST],
  dr := [2, IS_INC_POS_INT_LIST],
  #dump := [1, x -> (IsList(x) and x[1] in [0..2] and
  #                  (Length(x) = 1 or (Length(x) = 2 and x[2] in [0,1])) or
  #                 x in [0..2]],
  easy := [4, [""]],
  echo := [4, [0,1]],         # hijacked! ... we don't pass this to ACE
  enumeration := [4, IsString],
  felsch := [3, ["",0,1]],
  ffactor := [1, x -> IsZero(x) or IsPosInt(x)],# "ffactor" and "fill"
  fill := [3, x -> IsZero(x) or IsPosInt(x)],   # are synonyms ... there is
                                                # no "fi" since it's a GAP
                                                # keyword
  ## Most interface functions require the next 3 ACE options to be
  ## passed as arguments rather than options
  group := [2, x -> IsInt(x) or IsString(x) ],  # For group generators
  generators := [3, x -> IsList(x) and ForAll(x, xi -> IsWord(xi)) ],
                                                # For subgroup generators
  relators := [3, x -> IsList(x) and ForAll(x, xi -> IsWord(xi)) ],
                                                # For group relators
  hard := [2, [""]],
  #help := [4, [""]],
  hlt  := [3, [""]],
  hole := [4, [-1..100]],
  lookahead := [4, [0..4]],
  loop := [4, x -> IsZero(x) or IsPosInt(x)],
  max  := [3, x -> IsZero(x) or (IsInt(x) and x >= 2)],
  mendelsohn := [4, [0,1]],
  messages := [4, IsInt],   # "messages" and "monitor" are synonyms
  monitor := [3, IsInt],
  #mode := [2, [""]],
  nc   := [2, ["",0,1]],    # "nc" and "normal" are synonyms
  normal := [6, [0,1]],
  no   := [2, x -> IsInt(x) and x >= -1],
  #options := [3, [""]],
  oo   := [2, IsInt],       # "oo" and "order" are synonyms
  order := [2, IsInt],
  #parameters := [3, [""]], # decommissioned ACE option
  path := [4, [0,1]],
  pmode := [4, [0..3]],
  psize := [4, x -> IsZero(x) or 
                   (IsEvenInt(x) and IsPrimePowerInt(x))],
  #sr := [2, [0,1]],
  #print := [2, x -> (IsList(x) and Length(x) <= 3 and
  #                  ForAll(x, IsInt)) or IsInt(x)],
  purec := [5, [""]],       # the ACE option is "pure c"
  purer := [5, [""]],       # the ACE option is "pure r"
  rc   := [2, x -> (IsList(x) and Length(x) <= 2 and
                   ForAll(x, IsInt)) or IsInt(x)],
  recover := [4, [""]],     # "recover" and "contiguous"
  contiguous := [6, [""]],  # are synonyms ... "rec" is
                            # not an allowed abbreviation
                            # since it's a GAP  keyword
  rep  := [2, x -> (IsList(x) and Length(x) <= 2 and
                   ForAll(x, IsInt) and x[1] in [1..7]) or
                   x in [1..7]],
  #restart := [7, [""]],    # decommissioned ACE option
  rfactor := [1, IsInt],    # "rfactor" and "rt" are synonyms
  rt   := [2, IsInt],
  row  := [3, [0,1]],
  sc   := [2, IsInt],       # "sc" and "stabilising" are synonyms
  stabilising := [6, IsInt],
  sims := [4, [1,3,5,7,9]],
  standard := [2, [""]],
  statistics := [4, [""]],  # "statistics" and "stats" are synonyms
  stats := [5, [""]],
  #style := [5, [""]],
  subgroup := [4, IsString],
  system := [3, IsString],
  text := [4, IsString],
  time := [2, x -> IsInt(x) and x >= -1],
  #tw := [2, [int,<word>]], trace := [5, [int,<word>]],
  workspace := [2, x -> IsInt(x) or 
                        (IsString(x) and 
                         x[Length(x)] 
                             in "0123456789kmgKMG")]
));

#############################################################################
####
##
#V  NonACEbinOptions . . . . . . . list of known ACE options that are not ACE
##  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . binary options.
##

InstallValue(NonACEbinOptions,
  [ "aceinfile",     "aceoutfile", "aceignore", "aceignoreunknown",
    "acenowarnings", "echo",       "silent" ]
);

#############################################################################
####
##
#V  ACE_ERRORS . . . . . . . . . . . . record of ACE interface error messages
##
##

InstallValue(ACE_ERRORS, rec(
  argnotopt := "should be passed as an argument, NOT an option"
));

#############################################################################
####
##
#F  IS_INC_POS_INT_LIST . . . . . . Internal function used in KnownACEOptions
##  . . . . . . . .  returns true if argument is a single positive integer or
##  . . . . . . . . . . .  is a strictly increasing list of positive integers
##
InstallGlobalFunction(IS_INC_POS_INT_LIST, 
  x -> IsPosInt(x) or (IsSSortedList(x) and IsPosInt(x[1]) and x[1] < x[2]));

#############################################################################
####
##
#F  ACE_OPTIONS . . . . . . . . . . . . . . . . . . . . . . Internal function
##  . . . . . . . . . returns the options passed to an ACE interface function
##
##
InstallGlobalFunction(ACE_OPTIONS, function()
  if IsEmpty(OptionsStack) then
    return rec();
  else
    return OptionsStack[ Length(OptionsStack) ];
  fi;
end);

#############################################################################
####
##
#F  ACE_OPT_NAMES . . . . . . . . . . . . . . . . . . . . . Internal function
##  . . . . . . . .  returns option names passed to an ACE interface function
##  . . . . . . . . . . . . . if acenowarnings is not an option it also warns
##  . . . . . . . . . . . . . . . . . . . . . . . .  about deprecated options
##
InstallGlobalFunction(ACE_OPT_NAMES, function()
local optnames;
  optnames := RecNames(ACE_OPTIONS());
  if not VALUE_ACE_OPTION(optnames, false, [ "acenowarnings" ]) then
    if "messfile" in optnames then
      Info(InfoACE + InfoWarning, 1,
           "ACE Warning: ", 
           "Option `messfile' deprecated: use `ACEoutfile' instead");
    elif "outfile" in optnames then
      Info(InfoACE + InfoWarning, 1,
           "ACE Warning: ", 
           "Option `outfile' deprecated: use `ACEinfile' instead");
    fi;
  fi;
  return optnames;
end);

#############################################################################
####
##
#F  MATCHES_KNOWN_ACE_OPT_NAME  . . . . . . . . . . . . . . Internal function
##  . . . .  returns true iff optname is a valid abbreviation of knownoptname
##  . . . . . . . . . . . . . . . . . optname should be in lowercase already!
##
InstallGlobalFunction(MATCHES_KNOWN_ACE_OPT_NAME, 
function(knownoptname, optname)
  return optname = knownoptname{[1..Length(optname)]} and
         KnownACEOptions.(knownoptname)[1] <= Length(optname);
end);

#############################################################################
####
##
#F  FULL_ACE_OPT_NAME . . . . . . . . . . . . . . . . . .  Internal procedure
##  . . . . . . sets opt.fullname to be the unabbreviated version of opt.name
##  . . . . . . . . . . .  if one exists among the fields of KnownACEOptions,
##  . . . . . . . . . . . . . . in which case, opt.known is also set to true;
##  . . . . . . . . . . .  otherwise,  opt.fullname is set to  opt.name,  and
##  . . . . . . . . . . . . . . . . . . . . . . .  opt.known is set to false.
##
InstallGlobalFunction(FULL_ACE_OPT_NAME, function(opt)
local lcaseoptname, list;
  lcaseoptname := LowercaseString(opt.name);
  list := Filtered(RecNames(KnownACEOptions), 
                   s -> MATCHES_KNOWN_ACE_OPT_NAME(s, lcaseoptname));
  opt.known := not( IsEmpty(list) );
  if opt.known then
    opt.fullname := list[1];  # We assume any match is unique!
  else
    opt.fullname := opt.name;
  fi;
end);

#############################################################################
####
##
#F  VALUE_ACE_OPTION  . . . . . . . . . . . . . . . . . . . Internal function
##  . . . . . . .  checks among optnames for any settings of the known option
##  . . . . . . .  synonyms in list. The latest such optname in optnames will
##  . . . . . . .  prevail  and  its value will be  returned.  Otherwise,  if
##  . . . . . . . . . .  there isn't such an optname, defaultval is returned.
##
InstallGlobalFunction(VALUE_ACE_OPTION, function(optnames, defaultval, list)
local optname, optval;
  optval := defaultval;
  for optname in Filtered(optnames, 
                          optname -> ForAny(list, 
                                            s ->
                                            MATCHES_KNOWN_ACE_OPT_NAME(
                                                s, 
                                                LowercaseString(optname)
                                                )
                                            )) 
  do
    optval := ValueOption(optname);
  od;
  return optval;
end);
  
#############################################################################
####
##
#F  ACE_WORDS . . . . . . . . . . . . . . . . . . . . . . . Internal function
##  . . . . . . . . . .  returns the translation of words in generators fgens
##  . . . . . . . . . . .  to words in ACEgens (the generators ACE will use),
##  . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  as one string.
##
InstallGlobalFunction(ACE_WORDS, function(words, fgens, ACEgens)
  return ACE_JOIN( ACE_STRINGS( 
                       List(words, w -> MappedWord(w,
                                                   fgens,
                                                   GeneratorsOfGroup(
                                                       FreeGroup(ACEgens)
                                                       )))
                       ),
                   ","); # Words separated by commas
end);

#############################################################################
####
##
#F  PROCESS_ACE_OPTIONS . . . . . . . . . . . . . . . . .  Internal procedure
##  . . . . . . . . . for the ACE function with name ACEfname process options
##  . . . . . . . . . . by sending them to ACE after appropriate  translation
##  . . . . . . . . . . where  necessary  by writing via the function  ToACE,
##  . . . . . . . . . . mostly in the order specified by the  user.  If  echo
##  . . . . . . . . . . is  set  then  all options are echoed along  with  an 
##  . . . . . . . . . . indication of how they were handled by the interface.
##  . . . . . . . . . . If the InfoLevel of  InfoACE  or  InfoWarning  is  at 
##  . . . . . . . . . . least one then a warning message is issued  for  each
##  . . . . . . . . . . optname that is in the RecNames of disallowed  or  is 
##  . . . . . . . . . . . . . in ignored or for some other reason is ignored.
InstallGlobalFunction(PROCESS_ACE_OPTIONS, 
function(ACEfname, optnames, echo, ToACE, disallowed, ignored)
local IsValidOptionValue, CheckValidOption, ProcessOption, 
      AddIgnoreOptionsToIgnored, nowarnings, ignoreunknown, opt, optname;

  IsValidOptionValue := function(val)
    # Check that val is a valid value of opt.fullname.
    # This function will only be called when opt.known = true,
    # in which case, opt.fullname will be a field of KnownACEOptions
    if IsFunction(KnownACEOptions.(opt.fullname)[2]) then
      return KnownACEOptions.(opt.fullname)[2](val);
    elif IsBool(val) then
      return KnownACEOptions.(opt.fullname)[2] in ["", ["",0,1], [0,1]];
    else
      return val in KnownACEOptions.(opt.fullname)[2];
    fi;
  end;

  CheckValidOption := function(val)
    # If opt.fullname is a known allowed optname and val is a valid value,
    # warn the user of a possible error, if s/he wants to know.
    if not nowarnings then
      if opt.fullname in RecNames(disallowed) then
        Info(InfoACE + InfoWarning, 1,
             "ACE Warning: ", opt, ": ", disallowed.(opt.fullname));
      elif opt.known then
        if not IsValidOptionValue(val) then
          Info(InfoACE + InfoWarning, 1,
               "ACE Warning: ", val, ": ",
               "possibly not an allowed value of ", opt.name);
        fi;
      else
        Info(InfoACE + InfoWarning, 1,
             "ACE Warning: ", opt.name, ": unknown (maybe new) or bad option");
      fi;
    fi;
  end;

  ProcessOption := function(val)
    # Pass opt.ace (which is opt.name except for "purer" and "purec")
    # to ACE with value val, except if opt.name is to be ignored or 
    # is a NonACEbinOption. We also echo what we do, if the user has
    # set the echo option.
    if not opt.donothing and not opt.ignore then
      if opt.fullname{[1..4]} = "pure" then
        # Options "pure r" and "pure c" are the only ACE options
        # for which ACE did not have a single-word alternative.
        # So the corresponding GAP options are "purer" and "purec",
        # respectively. Here we reconstruct what ACE expects.
        opt.ace := Concatenation(opt.name{[1..4]}, " ", opt.name{[5]});
      else
        # The ACE optname is the same as the GAP optname
        opt.ace := opt.name;
      fi;
      if val = "" then
        ToACE([ opt.ace, ";\n" ]);
      else
        ToACE([ opt.ace, ":", val, ";\n" ]);
      fi;
    fi;
    if echo then
      if opt.ignore then
        Print(" ", opt.name, " := ", opt.value, " (ignored)\n");
      elif opt.fullname in NonACEbinOptions then
        if opt.fullname = "aceoutfile" then
          Print(" ", opt.name, " := ", opt.value, 
                " (passed to ACE via option: ao)\n");
        else
          Print(" ", opt.name, " := ", opt.value, " (not passed to ACE)\n");
        fi;
      elif val = "" then
        Print(" ", opt.name, " (no value)\n");
      else
        Print(" ", opt.name, " := ", val, "\n");
      fi;
    fi;
    # Warn user if opt.name is an unknown optname or has an unexpected value
    CheckValidOption(val);
  end;

  AddIgnoreOptionsToIgnored := function()
  local ignore, optname, opt;
    ignore := VALUE_ACE_OPTION(optnames, [], ["aceignore"]);
    for optname in ignore do
      opt := rec(name := optname);
      FULL_ACE_OPT_NAME(opt); # sets opt.known and opt.fullname
      if opt.known then
        Add(ignored, opt.fullname);
      elif not nowarnings then
        Info(InfoACE + InfoWarning, 1,
             "ACE Warning: ", opt.name, 
             " (option that user wished ignored) is not a known ACE option");
      fi;
    od;
  end;

  if echo then
    Print(ACEfname, " called with the following options:\n");
  fi;

  nowarnings := VALUE_ACE_OPTION(optnames, false, ["acenowarnings"]);
  ignoreunknown := VALUE_ACE_OPTION(optnames, false, ["aceignoreunknown"]);
  AddIgnoreOptionsToIgnored();

  for optname in optnames do
    opt := rec(name := optname);
    FULL_ACE_OPT_NAME(opt); # sets opt.known and opt.fullname
    # We don't pass the options in the RHS list following to ACE, here
    # (i.e. within this `for' loop). The NonACEbinOptions "echo", 
    # "aceinfile" and "silent" are not passed to ACE at all, and 
    # "aceoutfile" is only passed to the ACE as "ao" (and if available
    # to the calling function, has already been dealt with).
    opt.donothing := opt.fullname in ["echo", "aceinfile", "ao", "aceoutfile",
                                      "silent", "enumeration", "subgroup" ];
    opt.ignore := opt.fullname in RecNames(disallowed) or
                  opt.fullname in ignored or
                  (ignoreunknown and not opt.known);
    opt.value := ValueOption(opt.name);
    if opt.value = true then
      # An option detected by GAP as boolean may in fact be a no-value
      # option of ACE ... unknown ACE options detected as being true are
      # assumed to be no-value options (since the user can still over-ride
      # this behaviour by entering values of 0 or 1 explicitly e.g. 
      # ACEStats(... : `opt' := 1) )
      if not opt.known or IsValidOptionValue("") then
        ProcessOption("");
      else
        ProcessOption(1);
      fi; 
    elif opt.value = false then
      ProcessOption(0);
    elif not IsString(opt.value) and IsList(opt.value) then
      # ProcessOption() is not designed to cope with a list
      # ... we do it `manually'.
      if not opt.donothing then
        ToACE([ opt.name,":", 
                ACE_JOIN( ACE_STRINGS(opt.value), "," ), ";\n" ]);
      fi;
      if echo then 
        Print(" ", opt.name, " := ", opt.value, 
              " (brackets are not passed to ACE)\n");
      fi;
      CheckValidOption(opt.value);
    else
      ProcessOption(opt.value);
    fi;
  od;
end);

#############################################################################
####
##
#F  CurrentACEOptions . . . . . . . . . . .  Displays the current ACE options
##
##
InstallGlobalFunction(CurrentACEOptions, function(arg)
local datarec;
  if IsEmpty(arg) and IsBound(ACEData.options) then
    # This is the case where CurrentACEOptions is called
    # from a break-loop when a coset enumeration for
    # ACECosetTableFromGensAndRels has failed
    datarec := ACEData;
  else
    datarec := ACEData.io[ ACE_STREAM(arg) ];
  fi;
  if datarec.options = rec() then
    Print("No options.\n");
  else
    Display(datarec.options);
    Print("\n");
  fi;
end);

#############################################################################
####
##
#F  SetACEOptions . . . . . . . . . . . . . . . . . .  Updates stored options
##
##
InstallGlobalFunction(SetACEOptions, function(arg)
local datarec;
  if IsEmpty(arg) and IsBound(ACEData.options) then
    # This is the case where SetACEOptions is called
    # from a break-loop when a coset enumeration for
    # ACECosetTableFromGensAndRels has failed
    datarec := ACEData;
  else
    datarec := ACEData.io[ ACE_STREAM(arg) ];
  fi;
  if Length(OptionsStack) > 0 and
     (datarec <> ACEData or datarec.optionsStackDepth = Length(OptionsStack)) 
  then
    # User added some new options ...
    # since options is no longer on the OptionsStack
    # we have to pop off newoptions and then push back
    # options and newoptions, to get an updated options
    datarec.newoptions := OptionsStack[ Length(OptionsStack) ];
    PopOptions();
    PushOptions(datarec.options);
    PushOptions(datarec.newoptions);
    datarec.options := OptionsStack[ Length(OptionsStack) ];
    # We pop options here, to ensure OptionsStack is the same length
    # as before the call to SetACEOptions
    PopOptions();
    Unbind(datarec.newoptions);
  fi;
end);

#############################################################################
####
##
#F  FlushOptionsStack . . . . . . . . . . . Pops all options off OptionsStack
##
##
InstallGlobalFunction(FlushOptionsStack, function()
  while not(IsEmpty(OptionsStack)) do
    PopOptions();
  od;
end);

#############################################################################
####
##
#F  SET_ACE_OPTION  . . . . . . . . . . . . . . . . . . .  Internal procedure
##  . . . . . .  (No longer used, but retained in case a use is found for it)
##  . . . . . . . . . . .  Scans fields of options for matches with opt.name, 
##  . . . . . . . . . . .  unbinds them  and  sets  options.(opt.name) := val
##
InstallGlobalFunction(SET_ACE_OPTION, function(options, opt, val)
local optname;
  FULL_ACE_OPT_NAME(opt); # Sets opt.known and opt.fullname
  if opt.known then
    for optname in RecNames(options) do
      if MATCHES_KNOWN_ACE_OPT_NAME(opt.fullname, optname) then
        Unbind(options.(optname));
      fi;
    od;
  else
    for optname in RecNames(options) do
      if LowercaseString(opt.name) = LowercaseString(optname) then
        Unbind(options.(optname));
      fi;
    od;
  fi;
  options.(opt.name) := val;
end);

#E  options.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here 
