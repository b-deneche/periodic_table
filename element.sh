#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
  exit
fi
  if [[ ! -z  $1 && $1 =~ ^[0-9]+$ ]]
  then 
    ID=$($PSQL "select symbol from elements where atomic_number='$1'")
    ELEMENT_BY_ID=$($PSQL "select p.atomic_number,atomic_mass::REAL,melting_point_celsius,boiling_point_celsius,symbol,name,type_id from properties p join elements e on e.atomic_number=p.atomic_number where p.atomic_number=$1")
      if [[ -z $ID ]]
      then
      echo "I could not find that element in the database."
      else
      echo $ELEMENT_BY_ID | while read ATOMIC_NUM BAR MASS BAR MELTING BAR BOILING BAR SYMBOL BAR NAME BAR TYPE_ID
        do        
        TYPE=$($PSQL "select type from types where type_id = $TYPE_ID") 
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a$TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
  fi


###############################""
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[A-Za-z]{0,2}$ ]]
  then 
    ELEMENT_ID=$($PSQL "select atomic_number from elements where symbol='$1'")
    if [[ -z $ELEMENT_ID ]]
    then
    echo "I could not find that element in the database."
    else
    ELEMENT_BY_SYMBOL=$($PSQL "select p.atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,symbol,name,type_id from properties p join elements e on e.atomic_number=p.atomic_number where p.atomic_number=$ELEMENT_ID")
    echo $ELEMENT_BY_SYMBOL | while read ATOMIC_NUM BAR MASS BAR MELTING BAR BOILING BAR SYMBOL BAR NAME BAR TYPE_ID
      do        
      TYPE=$($PSQL "select type from types where type_id = $TYPE_ID")
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a$TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
fi
#search element with name

  if [[ $1 =~ ^[a-zA-Z]{3,20}$ ]]
  then
    ELEMENT_ID=$($PSQL "select atomic_number from elements where name like '$1'")
    if [[ -z $ELEMENT_ID ]]
    then
    echo "I could not find that element in the database."
    else
    ELEMENT_BY_SYMBOL=$($PSQL "select p.atomic_number,atomic_mass::REAL,melting_point_celsius,boiling_point_celsius,symbol,name,type_id from properties p join elements e on e.atomic_number=p.atomic_number where p.atomic_number=$ELEMENT_ID")
    echo $ELEMENT_BY_SYMBOL | while read ATOMIC_NUM BAR MASS BAR MELTING BAR BOILING BAR SYMBOL BAR NAME BAR TYPE_ID
      do        
            TYPE=$($PSQL "select type from types where type_id = $TYPE_ID")
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a$TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi