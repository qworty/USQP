<?
$printDebug = array();
function debug($message){
  global $printDebug;
     array_push($printDebug,$message);
}
function printDebug(){
  global $printDebug;
  $rander = rand();
  print "<span class='muted debugbox' onclick='toggleShow(\"debug-span-$rander\");'>";
  print "<span style='cursor:pointer;'><h5>Debugbox <i class='icon-sort-down'></i></h5></span>";
  print"<span id='debug-span-$rander' class='noshow'>";
  foreach($printDebug as $regel){
    print "$regel<br />\n";
  }
  print "</span>";
  print "</span>";
  $printDebug = array();
}

$printError = array();
function error($message){
  global $printError;
  array_push($printError,$message);
}
function printError(){
  global $printError;
  foreach($printError as $regel){
    print "<br />\nFATAL ERROR:<br />\n$regel\n<br /> FATAL ERROR!!\n<br />";
  }
  $printError = array();
}

$printSite = array();
function site($message,$linebreak=1){
  global $printSite;
  $break = "";
  if($linebreak){
    $break = "\n";
  }
  array_push($printSite,($message.$break));
}
function printSite(){
  global $printSite;
  foreach($printSite as $regel){
    print "$regel";
  }
  $printSite = array();
}

$tekstenSite = array();
function tekst($plek,$bericht,$linebreak=1){
  global $tekstenSite;
  if(!isset($tekstenSite[$plek])){
    $tekstenSite[$plek] = array();
  }
  $break = "";
  if($linebreak){
    $break = "\n";
  }
  array_push($tekstenSite[$plek],($bericht.$break));
}
function printTekst($plek,$return=0){
  global $tekstenSite;
  if(isset($tekstenSite[$plek])){
    $teksten =  $tekstenSite[$plek];
    $tekstenSite[$plek] = array();
  }else{
    return 0;
  }
  if($return){
      return $teksten;
  }
  else{
    foreach($teksten as $tekst){
         site($tekst,0);
    }
  }
}
?>
