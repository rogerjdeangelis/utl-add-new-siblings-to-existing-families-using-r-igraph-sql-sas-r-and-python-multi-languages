%let pgm=utl-add-new-siblings-to-existing-families-using-r-igraph-sql-sas-r-and-python-multi-languages;

Add new siblings to existing families using r igraph sql sas r and python multi languages

OUTPUT GRAPHIC
https://tinyurl.com/bdf6m2m4
https://github.com/rogerjdeangelis/utl-add-new-siblings-to-existing-families-using-r-igraph-sql-sas-r-and-python-multi-languages/blob/main/igraph.pdf

github
https://tinyurl.com/3rjfzdya
https://github.com/rogerjdeangelis/utl-add-new-siblings-to-existing-families-using-r-igraph-sql-sas-r-and-python-multi-languages

This is not a trivial problem. Recusive linking.

   SOLUTIONS

      1 r igraph prefered
      2 sas sql
      3 r sql
      4 python sql


https://stackoverflow.com/questions/79032396/updating-a-sas-table-dynamically-as-new-records-come-in

RELATED REPOS
-------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-interaction-between-a-Network-Diagram-and-a-Sankey-diagram-r-networkD3
https://github.com/rogerjdeangelis/utl-how-many-triangles-in-the-polygon-r-igraph-AI
https://github.com/rogerjdeangelis/utl-identify-linked-and-unliked-paths-r-igraph
https://github.com/rogerjdeangelis/utl-igraph-find-largest-group-of-unrelated-individuals-in-your-family-reunion
https://github.com/rogerjdeangelis/utl-linking-connected-nodes-in-a-network-graph-r-igraph
https://github.com/rogerjdeangelis/utl-R-AI-igraph-list-connections-in-a-non-directed-graph-for-a-subset-of-vertices
https://github.com/rogerjdeangelis/utl-shortest-and-longest-travel-time-from-home-to-work-igraph-AI
https://github.com/rogerjdeangelis/utl_remove_isolated_nodes_from_an_network_r_igraph

/*   _             _                        __ _                _               _         __       _ _    ___
 ___| |_ __ _  ___| | _______   _____ _ __ / _| | _____      __| |__   __ _ ___| |__     / _| __ _(_) |__|__ \
/ __| __/ _` |/ __| |/ / _ \ \ / / _ \ `__| |_| |/ _ \ \ /\ / /| `_ \ / _` / __| `_ \   | |_ / _` | | / __|/ /
\__ \ || (_| | (__|   < (_) \ V /  __/ |  |  _| | (_) \ V  V / | | | | (_| \__ \ | | |  |  _| (_| | | \__ \_|
|___/\__\__,_|\___|_|\_\___/ \_/ \___|_|  |_| |_|\___/ \_/\_/  |_| |_|\__,_|___/_| |_|  |_|  \__,_|_|_|___(_)
*/


I don't think the stackoverflow hash solution works because if you change the oder of input in the new dataset
you get I different result

   ORDER  JANE BRAD                               ORDER
          BRAD FRAN                               BRAD FRAN
  ------------------------------------------      JANE BRAD --------------------------------------------

  data new;             FAMILY    ID_SIBLING      data new;              FAMILY    ID_SIBLING
  input ID $ family $;                            input ID $ family $;
  cards4;               JONES        JOHN         cards4;                JONES        JOHN
  JANE BRAD             JONES        JUDY         BRAD FRAN              JONES        JUDY
  BRAD FRAN             JONES        JANE         JANE BRAD              JONES        JANE
  ;;;;                  SMITH        MARY         ;;;;                   SMITH        MARY
  run;quit;             HOMES        MIKE         run;quit;              HOMES        MIKE
                        JONES        BRAD                                BRAD         FRAN
                        JONES        FRAN                                JONES        BRAD

/*               _     _                     _        _                            _
 _ __  _ __ ___ | |__ | | ___ _ __ ___   ___| |_ __ _| |_ ___ _ __ ___   ___ _ __ | |_
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \ / __| __/ _` | __/ _ \ `_ ` _ \ / _ \ `_ \| __|
| |_) | | | (_) | |_) | |  __/ | | | | |\__ \ || (_| | ||  __/ | | | | |  __/ | | | |_
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_||___/\__\__,_|\__\___|_| |_| |_|\___|_| |_|\__|
|_|

*/

  If the existing family is the Jones family
   with three offspring

      JONES JOHN
      JONES JUDY
      JONES JANE (in families and new relationship datasets)

  And these new sibling renationships
   are to be added

      BRAD JANE
      FRAN BRAD

  Result
  Brad is Janes new brother
  and Fran is Brads new sister thus
  Jane, Brad and Fran are in
  the Jones family

  New augmented Jones Family

      JONES JOHN
      JONES JUDY
      JONES JANE

      JONES BRAD  ADDED
      JONES FRAN

  Basically A=B and B=C then A=C


/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                        |                                            |                                                  */
/*    INPUT               |        PROCESS                             |                    OUTPUT                        */
/*    =====               |        =======                             |                    =======                       */
/*                        |                                            |                                                  */
/*                        |  R  ( a one liner)                         |                                                  */
/*                        |  -----------------                         |                     SIBLINGS                     */
/*                        |                                            |        +------------------------------+          */
/*   FRO      TO          |  g <- graph_from_data_frame(have);         |  SMITH + MARY                         + SMITH    */
/*                        |                                            |        |                              |          */
/*  JONES    JOHN         |--------------------------------------------|  JONES + BRAD->FRAN->JANE->JOHN->JUDY + JONES    */
/*  JONES    JUDY         |                                            |        |                              |          */
/*  JONES    JANE         |  SAS R and PYTHON (CAN NEST FOR SPEED)     |  HOMES + MIKE                         + HOMES    */
/*  SMITH    MARY         |  -------------------------------------     |        +------------------------------+          */
/*  HOMES    MIKE         |                                            |                      SIBLINGS                    */
/*  FRAN     BRAD         |  proc sql;                                 |                                                  */
/*  BRAD     JANE         |    create                                  |                                                  */
/*                        |       table add_sibling as                 |  FAMILY SIBLING                                  */
/*                        |    select                                  |                                                  */
/*                        |       l.family                             |  JONES  JOHN                                     */
/*                        |      ,r.sibling1  as sibling1              |  JONES  JUDY                                     */
/*                        |      ,l.sibling   as sibling2              |  JONES  JANE                                     */
/*                        |    from                                    |  JONES  BRAD                                     */
/*                        |       families as l, siblings as r         |  JONES  JANE                                     */
/*                        |    where                                   |  SMITH  MARY                                     */
/*                        |          l.sibling =r.sibling2             |  HOMES  MIKE                                     */
/*                        |       or l.sibling =r.sibling1             |                                                  */
/*                        |  ;                                         |                                                  */
/*                        |    create                                  |                                                  */
/*                        |       table add_sibling2 as                |                                                  */
/*                        |    select                                  |                                                  */
/*                        |       l.family                             |                                                  */
/*                        |      ,r.sibling1                           |                                                  */
/*                        |      ,r.sibling2                           |                                                  */
/*                        |    from                                    |                                                  */
/*                        |       add_sibling as l, siblings as r      |                                                  */
/*                        |    where                                   |                                                  */
/*                        |          l.sibling1 =r.sibling2            |                                                  */
/*                        |       or l.sibling1 =r.sibling1            |                                                  */
/*                        |    ;                                       |                                                  */
/*                        |    create                                  |                                                  */
/*                        |       table want as                        |                                                  */
/*                        |    select                                  |                                                  */
/*                        |       family                               |                                                  */
/*                        |      ,sibling as sibling1                  |                                                  */
/*                        |    from                                    |                                                  */
/*                        |       families                             |                                                  */
/*                        |    union                                   |                                                  */
/*                        |       corr                                 |                                                  */
/*                        |    select                                  |                                                  */
/*                        |       family                               |                                                  */
/*                        |      ,sibling1                             |                                                  */
/*                        |    from                                    |                                                  */
/*                        |       add_sibling                          |                                                  */
/*                        |    union                                   |                                                  */
/*                        |       corr                                 |                                                  */
/*                        |    select                                  |                                                  */
/*                        |       family                               |                                                  */
/*                        |      ,sibling1                             |                                                  */
/*                        |    from                                    |                                                  */
/*                        |       add_sibling2                         |                                                  */
/*                        |  ;quit;                                    |                                                  */
/*                        |                                            |                                                  */
/**************************************************************************************************************************/


/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname sd1 "d:/sd1";

options validvarname=upcase;

data sd1.families;
input family $ sibling $ ;
cards4;
JONES JOHN
JONES JUDY
JONES JANE
SMITH MARY
HOMES MIKE
;;;;
run;quit;

data sd1.siblings;
input sibling1 $ sibling2 $;
cards4;
FRAN BRAD
BRAD JANE
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.FAMILIES total obs=5     SD1.SIBLINGS total obs=2                                                                 */
/*                                                                                                                        */
/*   FAMILY    SIBLING           SIBLING1    SIBLING2                                                                     */
/*                                                                                                                        */
/*   JONES      JOHN               FRAN        BRAD                                                                       */
/*   JONES      JUDY               BRAD        JANE                                                                       */
/*   JONES      JANE                                                                                                      */
/*   SMITH      MARY                                                                                                      */
/*   HOMES      MIKE                                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*          _                       _
/ |  _ __  (_) __ _ _ __ __ _ _ __ | |__
| | | `__| | |/ _` | `__/ _` | `_ \| `_ \
| | | |    | | (_| | | | (_| | |_) | | | |
|_| |_|    |_|\__, |_|  \__,_| .__/|_| |_|
              |___/          |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete rwant ;
run;quit;

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  set
   sd1.families(rename=(sibling =to family  =fro ))
   sd1.siblings(rename=(sibling2=to sibling1=fro ))
  ;
run;quit;

%utlfkil("d:/pdf/igraph.pdf");

%utl_rbeginx;
parmcards4;
library(sqldf);
library(igraph);
library(tidyverse);
library(haven)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
g <- graph_from_data_frame(have);
pdf("d:/pdf/igraph.pdf",width = 5, height =4);
plot(g);
pdf();
comp <- components(g)$membership;
want<-have %>%
  mutate(group = comp[match(FRO, names(comp))]) %>%
  mutate(id = first(FRO), .by = "group") %>%
  select(-group);
want<-want[,-1];
colnames(want)<-c("SIBLING","FAMILY")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* R                      SAS                                                                                             */
/*                                                                                                                        */
/*    SIBLING FAMILY      ROWNAMES    SIBLING    FAMILY                                                                   */
/*                                                                                                                        */
/*  1 JOHN    JONES           1        JOHN      JONES                                                                    */
/*  2 JUDY    JONES           2        JUDY      JONES                                                                    */
/*  3 JANE    JONES           3        JANE      JONES                                                                    */
/*  4 MARY    SMITH           4        MARY      SMITH                                                                    */
/*  5 MIKE    HOMES           5        MIKE      HOMES                                                                    */
/*  6 BRAD    JONES           6        BRAD      JONES                                                                    */
/*  7 JANE    JONES           7        JANE      JONES                                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*___                              _
|___ \   ___  __ _ ___   ___  __ _| |
  __) | / __|/ _` / __| / __|/ _` | |
 / __/  \__ \ (_| \__ \ \__ \ (_| | |
|_____| |___/\__,_|___/ |___/\__, |_|
                                |_|
*/

proc datasets lib=work nolist nodetails;
 delete want add_sibling add_sibling2;
run;quit;

proc sql;
  create
     table add_sibling as
  select
     l.family
    ,r.sibling1  as sibling1
    ,l.sibling   as sibling2
  from
     sd1.families as l, sd1.siblings as r
  where
     l.sibling =r.sibling2 or l.sibling =r.sibling1
;
  create
     table add_sibling2 as
  select
     l.family
    ,r.sibling1
    ,r.sibling2
  from
     add_sibling as l, sd1.siblings as r
  where
     l.sibling1 =r.sibling2 or l.sibling1 =r.sibling1
  ;
  create
     table want as
  select
     family
    ,sibling as sibling1
  from
     families
  union
     corr
  select
     family
    ,sibling1
  from
     add_sibling
  union
     corr
  select
     family
    ,sibling1
  from
     add_sibling2
;quit;

proc print data=want;
run;quit;

data plot;
  set want;
  txt=">"!!sibling1;
run;quit;

options ls=64 ps=18;
proc plot data=plot;
  plot family*sibling1='*' $ txt /box;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*    FAMILY    SIBLING1                                                                                                  */
/*                                                                                                                        */
/*    HOMES       MIKE                                                                                                    */
/*    JONES       BRAD                                                                                                    */
/*    JONES       FRAN                                                                                                    */
/*    JONES       JANE                                                                                                    */
/*    JONES       JOHN                                                                                                    */
/*    JONES       JUDY                                                                                                    */
/*    SMITH       MARY                                                                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                    _
|___ /   _ __   ___  __ _| |
  |_ \  | `__| / __|/ _` | |
 ___) | | |    \__ \ (_| | |
|____/  |_|    |___/\__, |_|
                       |_|
*/
libname sd1 "d:/sd1";

proc datasets lib=sd1 nolist nodetails;
 delete rwant ;
run;quit;

%utl_rbeginx;
parmcards4;
library(sqldf);
library(igraph);
library(haven)
source("c:/oto/fn_tosas9x.R")
families<-read_sas("d:/sd1/families.sas7bdat")
siblings<-read_sas("d:/sd1/siblings.sas7bdat")
print(families)
print(siblings)
add_sibling <-sqldf("
  select
     l.family
    ,r.sibling1  as sibling1
    ,l.sibling   as sibling2
  from
     families as l inner join siblings as r
  where
     l.sibling =r.sibling2 or l.sibling =r.sibling1
  ")
add_sibling
add_sibling2=sqldf("
  select
     l.family
    ,r.sibling1
    ,r.sibling2
  from
     add_sibling as l, siblings as r
  where
     l.sibling1 =r.sibling2 or l.sibling1 =r.sibling1
  ")
add_sibling2
want=sqldf("
  select
     family
    ,sibling as sibling1
  from
     families
  union
  select
     family
    ,sibling1
  from
     add_sibling
  union
  select
     family
    ,sibling1
  from
     add_sibling2
  ")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rrwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rrwant;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/* R > want             SAS                                                                                               */
/*                                                                                                                        */
/*   FAMILY sibling1    ROWNAMES    FAMILY    SIBLING1                                                                    */
/*                                                                                                                        */
/* 1  HOMES     MIKE        1       HOMES       MIKE                                                                      */
/* 2  JONES     BRAD        2       JONES       BRAD                                                                      */
/* 3  JONES     FRAN        3       JONES       FRAN                                                                      */
/* 4  JONES     JANE        4       JONES       JANE                                                                      */
/* 5  JONES     JOHN        5       JONES       JOHN                                                                      */
/* 6  JONES     JUDY        6       JONES       JUDY                                                                      */
/* 7  SMITH     MARY        7       SMITH       MARY                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                 _   _                             _
| || |    _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
| || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
|__   _| | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
   |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
         |_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
families,meta = ps.read_sas7bdat('d:/sd1/families.sas7bdat');
siblings,meta = ps.read_sas7bdat('d:/sd1/siblings.sas7bdat');
add_sibling = pdsql('''
  select
     l.family
    ,r.sibling1  as sibling1
    ,l.sibling   as sibling2
  from
     families as l inner join siblings as r
  where
     l.sibling =r.sibling2 or l.sibling =r.sibling1
  ''')
print(add_sibling)
add_sibling2 = pdsql('''
  select
     l.family
    ,r.sibling1
    ,r.sibling2
  from
     add_sibling as l, siblings as r
  where
     l.sibling1 =r.sibling2 or l.sibling1 =r.sibling1
  ''')
print(add_sibling2)
want = pdsql('''
  select
     family
    ,sibling as sibling1
  from
     families
  union
  select
     family
    ,sibling1
  from
     add_sibling
  union
  select
     family
    ,sibling1
  from
     add_sibling2
  ''')
print(want)
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*    FAMILY SIBLING1       FAMILY    SIBLING1                                                                            */
/*                                                                                                                        */
/*  0  HOMES     MIKE       HOMES       MIKE                                                                              */
/*  1  JONES     BRAD       JONES       BRAD                                                                              */
/*  2  JONES     FRAN       JONES       FRAN                                                                              */
/*  3  JONES     JANE       JONES       JANE                                                                              */
/*  4  JONES     JOHN       JONES       JOHN                                                                              */
/*  5  JONES     JUDY       JONES       JUDY                                                                              */
/*  6  SMITH     MARY       SMITH       MARY                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
