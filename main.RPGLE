      *%CSTD===========================================================*
      *%ECSTD==========================================================*


      *================================================================*
      *             Déclaration des fichiers                           *
      *================================================================*

     Feffectifl uf   e           k disk
     Feffectifl1uf   e           k disk    rename(effectiff:effectif1f)

      *================================================================*
      *             Déclaration des variables                          *
      *================================================================*

      *Paramètre d'entrée
     Dpe_ste           s              2
     Dpe_etb           s              2
     Dpe_nom           s                   like(nom)
     Dpe_prenom        s                   like(prenom)
     Dpe_matricule     s                   like(matricule)

      *Variable de travail
     Dwn_NbAgeEnPlus   s              2  0
     Dwmsg             s             35    inz('Warning! les 2 sont renseignés')
      *================================================================*
      *             Début du programme                                 *
      *================================================================*

      *Déclaration des paramètres
     C     *entry        plist
     C                   parm                    pe_ste
     C                   parm                    pe_etb
     C                   parm                    pe_nom
     C                   parm                    pe_prenom
     C                   parm                    pe_matricule

      *Déclaration des clés
     C     cle_effectif1 klist
     C                   kfld                    pe_nom
     C                   kfld                    pe_prenom
      *-------------------*
      *Début du programme *
      *-------------------*

      *Initialisation
     C                   eval      wn_NbAgeEnPlus = 3

      *Message d'erreur si Matricule et Nom sont renseignés en même temps
B001 C                   if        pe_Nom <> *blanks and pe_Matricule <> *zeros
      *message d'erreur  "Attention les deux sont renseignés"
 001 C                   dsply                   wmsg
 001 C                   eval      *inlr = *on
 001 C                   return
E001 C                   endif

      *Traitement de la demande avec le logique si le nom est renseigné
B001 C                   if        pe_Nom <> ' '
 001 C     cle_effectif1 chain     effectif1f
B002 C                   if        %found
 002 C                   eval      anciennete += wn_NbAgeEnPlus
 002 C                   update    effectif1f
E002 C                   endif
E001 C                   endif

      *Traitement de la demande avec le physique si le matricule est renseigné
B001 C                   if        pe_Matricule <> 0
 001 C     pe_Matricule  chain     effectiff
B002 C                   if        %found
 002 C                   eval      anciennete += wn_NbAgeEnPlus
 002 C                   update    effectiff
E002 C                   endif
E001 C                   endif

      *Fin du pgm
     C                   eval      *inlr = *on 