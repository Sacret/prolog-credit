/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formNewClientYur
    inherits formWindow
    open core, vpiDomains

constants
    className = "formNewClientYur/formNewClientYur".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display (Parent) = Form :-
        Form = new (Parent),
        Form : show ().

clauses
    new(Parent):-
        formWindow :: new (Parent),
        generatedInitialize ().

% предикаты в БД
class facts - yurDB
  predpr : (string Nazv, string Adr, string Chet, string Deyat, string Ufio, 
                string Goal, integer Summa, integer Srok, string Vidkr,
                integer Den1, string Mes1, integer God1).  
  predpr1 : (string Nazv, string Adr, string Chet, string Deyat, string Ufio, integer Dol,
                string Goal, integer Summa, integer Srok, string Vidkr,  string Zalog, integer Kol,
                integer Doh1, integer Doh2, integer Doh3,  integer Rash1, integer Rash2, 
                integer Rash3, integer Rash4, integer Rash5, integer Rash6, integer Rash7,
                integer Rash8, string Kreditor,  integer Sumz, integer Sump).                 
  
% чтение данных
predicates
    reconsult : (string FileName).    
clauses
   reconsult (Filename) :-                       
                 retractFactDb (yurDB),
                 file :: consult (FileName, yurDB).

% рассмотрение заявки
predicates
    onRassmClick : button :: clickResponder.
clauses
    onRassmClick(_Source) = button :: defaultAction :-
    % чтение данных
      NAZV =  nazv_ctl : getText (),  
      ADR = adr1_ctl : getText (),          
      CHET = chet_ctl : getText (),
      DEYAT2 = deyat_ctl : getText(),
      UFIO = fio_ctl : getText (), 
      hasDomain(integer, DOL),    
      DOL = toterm (dkap_ctl : getText()),	 
      GOAL = goal_ctl : getText (),
      hasDomain(integer, SUMMA),    
      SUMMA = toterm (summa_ctl : getText()),	
      hasDomain(integer, SROK),    	
      SROK = toterm (srok_ctl : getText()),
      VIDKR = vidkr_ctl : getSelectedIndices(),
      VIDKR2 = vidkr_ctl : getText(),
      ZALOG = zalog_ctl : getSelectedIndices(),
      %
      hasDomain(integer, KOL),    
      KOL = toterm (kolsotr_ctl : getText()),	
      hasDomain(integer, DOH1),    
      DOH1 = toterm (real_ctl : getText()),	
      hasDomain(integer, DOH2),    
      DOH2 = toterm (okusl_ctl : getText()),
      hasDomain(integer, DOH3),    
      DOH3 = toterm (prdoh_ctl : getText()),	
      hasDomain(integer, RASH1),    
      RASH1 = toterm (zak_ctl : getText()),	
      hasDomain(integer, RASH2),    
      RASH2 = toterm (zp_ctl : getText()),		
      hasDomain(integer, RASH3),    
      RASH3 = toterm (transp_ctl : getText()),	
      hasDomain(integer, RASH4),    
      RASH4 = toterm (nalog_ctl : getText()),	
      hasDomain(integer, RASH5),    
      RASH5 = toterm (arenda_ctl : getText()),	
      hasDomain(integer, RASH6),    
      RASH6 = toterm (rekl_ctl : getText()),
      hasDomain(integer, RASH7),    
      RASH7 = toterm (rashsem_ctl : getText()),		
      hasDomain(integer, RASH8),    
      RASH8 = toterm (prrash_ctl : getText()),	  
      KR = kreditor_ctl : getText(),	
      hasDomain(integer, SUMZ),    
      SUMZ = toterm (sum_ctl : getText()),	
      hasDomain(integer, SUMP),    
      SUMP = toterm (sum2_ctl : getText()),	
      hasDomain (integer, D1),    
      D1 = toterm (den2_ctl : getText()),                                                     
      M1 = mes2_ctl : getText(),                                         
      hasDomain(integer, G1),    
      G1 = toterm (dr2_ctl : getText()),   
   % формирование ответа  
      result (VIDKR, SROK, DOH1, DOH2, DOH3, RASH1, RASH2, RASH3, RASH4, RASH5, RASH6, 
                RASH7, RASH8, SUMP, SUMMA, KOL, DOL, SUMZ, ZALOG, RES, OTV),    
   %
     stdio :: write ("Результат рассмотрения заявки для компании: ", NAZV, "\n", OTV, "\n"), 
   % запись в файл
     reconsult ("yurdb.txt"),
      if (RES = 1)
         then
         (
             if ( predpr1(NAZV,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) ), !
               then
               (
                  retract ( predpr1(NAZV,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) )
               )
               end if,
             asserta (predpr (NAZV, ADR, CHET, DEYAT2, UFIO, GOAL, SUMMA, SROK, VIDKR2, D1, M1, G1) ),
             print (NAZV, ADR, CHET, DEYAT2, UFIO,  GOAL, VIDKR2, KR, M1)             
         )
         else
         (
            if (not (predpr1(NAZV,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) ) )
              then assertz (predpr1 (NAZV, ADR, CHET, DEYAT2, UFIO, DOL, GOAL, SUMMA, SROK, VIDKR2, zalog_ctl : getText(),  KOL, DOH1, DOH2, DOH3,
                                              RASH1, RASH2, RASH3, RASH4, RASH5, RASH6, RASH7, RASH8, KR, SUMZ, SUMP))
              end if
         )
         end if,
     % сохранение результата
      file :: save ("yurdb.txt", yurDB),    
    % очистка полей формы    
      nazv1_ctl : setVisible (false), 
      nazv_ctl : setVisible (true),
      obnul,
        !.%CUT
  onRassmClick(_Source) = button :: defaultAction. % catch all. If the first clause fails, it comes here 

% рассмотрение заявки и результат
predicates
  result :  (positive* Vidkr, integer Srok, integer Doh1, integer Doh2, integer Doh3, integer Rash1, integer Rash2, integer Rash3, integer Rash4,
               integer Rash5, integer Rash6, integer Rash7, integer Rash8, integer Sump, integer Summa, integer Kol, integer Dol, 
               integer Sumz, positive* Zalog, integer Res, string Otv)
               multi (i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,o,o). 
clauses
  result (Vidkr,Srok,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0, "Кредит в форме овердрафта выдаётся на срок не более одного месяца") :-
     Vidkr = [2], Srok>1.
  result (_,Srok,Doh1,Doh2,Doh3,Rash1,Rash2,Rash3,Rash4,Rash5,Rash6,Rash7,Rash8,Sump,Summa,_,_,_,_,0, "Ежемесячных доходов компании недостаточно для погашения кредита") :-  
     (Doh1 + Doh2 + Doh3 - Rash1 - Rash2 - Rash3 - Rash4 - Rash5 - Rash6 - Rash7 - Rash8) < Sump + (Summa / Srok).
  result (_,_,_,_,_,_,Rash2,_,_,_,_,_,_,_,Summa,Kol,Dol,Sumz,Zalog,0, "Заключение договора с Вашей компанией - слишком большой риск для нашего банка") :-  
     (Rash2 / Kol < 5.2) or
     (Dol<10, Sumz > Summa) or
     (Sumz > Summa, Zalog < [3]).    
  result (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Res,Otv) :-        
     Res = 1,
     Otv = "Для получения кредита обратитесь с заявлением (1.txt) в любое отделение банка. Перечень необходимых документов находится в соответствующем разделе".          
      
% формирование выходного документа
predicates
  print : (string Nazv, string Adr, string Chet, string Deyat, string Ufio, string Goal, string Vidkr, string Kreditor, string Mes1).
clauses
  print (NAZV, ADR, CHET, DEYAT2, UFIO,  GOAL, VIDKR2, KR, M1) :-
           ZAYA1 = string :: concat ("\tЗАЯВЛЕНИЕ:\nНазвание предприятия : ", NAZV, "\nЮридический адрес: ", ADR, "\nРасчётный счёт: ", CHET),
           ZAYA2 = string :: concat (ZAYA1, "\nВид деятельности: ",  DEYAT2, "\nУчредитель (Ф. И. О.): ", UFIO, "\nДоля в капитале: "),
           ZAYA3 = string :: concat (ZAYA2, dkap_ctl : getText(), "%\nЦель кредита: ", GOAL, "\nКредит на сумму: ", summa_ctl : getText()),
           ZAYA4 = string :: concat (ZAYA3, " тыс. руб.\nНа срок:: ", srok_ctl : getText(), " месяцев\nВид кредита: ", VIDKR2),
           ZAYA5 = string :: concat (ZAYA4, "\nЗалог: ", zalog_ctl : getText(), "\nКол-во сотрудников: ", kolsotr_ctl : getText(), "\nДоход от реализации товаров: "),
           ZAYA6 = string :: concat (ZAYA5, real_ctl : getText(), " тыс. руб.\nДоход от оказания услуг: ", okusl_ctl : getText(), " тыс. руб.\nПрочие доходы: ", prdoh_ctl : getText()),
           ZAYA7 = string :: concat (ZAYA6, " тыс. руб.\nРасход на закупку товаров: ", zak_ctl : getText(), " тыс. руб.\nРасход на З/П работников: ", zp_ctl : getText(), " тыс. руб.\nРасход на транспорт: "),
           ZAYA8 = string :: concat (ZAYA7, transp_ctl : getText(), " тыс. руб.\nНалоги: ", nalog_ctl : getText(), " тыс. руб.\nРасход на аренду: ", arenda_ctl : getText()),
           ZAYA9 = string :: concat (ZAYA8, " тыс. руб.\nРасход на рекламу: ", rekl_ctl : getText(), " тыс. руб.\nРасходы на семью: ", rashsem_ctl : getText(), " тыс. руб.\nПрочие расходы: "),
           ZAYA10 = string :: concat (ZAYA9, prrash_ctl : getText(), " тыс. руб.\nКредитор: ", KR, "\nСумма задолженности: ", sum_ctl : getText()),
           ZAYA11 = string :: concat (ZAYA10, " тыс. руб.\nСумма погашения в месяц: ", sum2_ctl : getText(),  " тыс. руб.\nДата: "),
           ZAYA12 = string :: concat (ZAYA11, den2_ctl : getText(), " ", M1, " ", dr2_ctl : getText()),
           file :: writeString ("1.txt", ZAYA12 , true).
      
% обнуление полей формы    
predicates
    obnul : ().
clauses
    obnul () :-
      nazv_ctl : setText (""),
      adr1_ctl : setText (""),
      chet_ctl : setText (""),
      deyat_ctl : setText (""),
      fio_ctl : setText (""),
      dkap_ctl : setText (""),
      goal_ctl : setText (""),
      summa_ctl : setText (""),
      srok_ctl : setText (""),
      kolsotr_ctl : setText (""),
      real_ctl : setText (""),
      okusl_ctl : setText (""),
      prdoh_ctl : setText (""),
      zak_ctl : setText (""),
      zp_ctl : setText (""),
      transp_ctl : setText (""),
      nalog_ctl : setText (""),
      arenda_ctl : setText (""),
      rekl_ctl : setText (""),
      rashsem_ctl : setText (""),
      prrash_ctl : setText (""),
      kreditor_ctl : setText (""),
      sum_ctl : setText (""),
      sum2_ctl : setText (""),
      dr2_ctl : setText (""),
      deyat_ctl : selectAt(0, true),
      vidkr_ctl : selectAt(0, true),
      zalog_ctl : selectAt(0, true),
      den2_ctl : selectAt(0, true),
      mes2_ctl : selectAt(0, true).   

% при открытии формы  
predicates
    onShow : window::showListener.
    listAdd : ().
clauses
    onShow (_Source, _Data) :-
      nazv1_ctl : setVisible (false), 
      nazv_ctl : setVisible (true),
      listAdd.
      
% добавление полей в листбоксы      
clauses
    listAdd () :-
      deyat_ctl : addList (["~","управление","правоохранительные органы", "детективное предприятие", "научная организация", "машиностроение", 
                                    "сельское хозяйство", "легкая и пищевая промышленность", "строительство", "транспорт", "культура и искусство", "образование",
                                    "здравоохранение", "торговля", "другое"]),
      den2_ctl : addList (["~","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]),
      mes2_ctl : addList (["~","января","февраля","марта","апреля","мая","июня","июля","августа","сентября","октября","ноября","декабря"]),
      vidkr_ctl : addList (["~","кредит", "овердрафт", "кредитная линия", "инвестиционный кредит"]),
      zalog_ctl : addList (["~","товарные запасы, сырьё", "товары в обороте", "оборудование и транспорт", "недвижимость", "депозит", "ценные бумаги"]).    

% определение номера позиции в листбоксе
predicates
  nomer : (string *Stroka, string Search, integer Nomer1, integer Nomer2) 
		nondeterm  (i,i,i,o).
clauses 
  nomer ([Search|_], Search, Nomer1, Nomer2) :- Nomer2 = Nomer1.
  nomer ([_|Ostatok], Search, Nomer1, Nomer2) :-  
     Nomer3 = Nomer1 + 1,
     nomer (Ostatok, Search, Nomer3, Nomer2). 

% запись данных на форму
predicates
    print : ().
    info : (string Stroka).
    
clauses
   print () :-
     nazv1_ctl : clearAll(),
     predpr1 (Name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),
     nazv1_ctl : add (Name),
     fail.
     print () :- !.

clauses
  info (Name) :-
    predpr1 (Name, ADR, CHET, DEYAT, UFIO, DOL, GOAL, SUMMA, SROK, VIDKR, ZALOG, KOL, DOH1, DOH2, DOH3,
                  RASH1, RASH2, RASH3, RASH4, RASH5, RASH6, RASH7, RASH8, KR, SUMZ, SUMP),
    nazv_ctl : setText (Name),
    adr1_ctl : setText (Adr),
    chet_ctl : setText (Chet), 
    nomer (deyat_ctl : getAll(), DEYAT, 0, R),   
    deyat_ctl : selectAt (R, true),   
    nomer (vidkr_ctl : getAll (), VIDKR, 0, P),
    vidkr_ctl : selectAt (P, true), 
    nomer (zalog_ctl : getAll (), ZALOG, 0, L),
    zalog_ctl : selectAt (L, true),             
    fio_ctl : setText (Ufio), 
    dkap_ctl : setText (tostring(DOL)), 
    goal_ctl : setText (GOAL),    
    summa_ctl : setText (tostring(SUMMA)),   
    srok_ctl : setText (tostring(SROK)),  
    kolsotr_ctl : setText (tostring(KOL)),     
    real_ctl : setText (tostring(DOH1)), 
    okusl_ctl : setText (tostring(DOH2)),  
    prdoh_ctl : setText (tostring(DOH3)),
    zak_ctl : setText (tostring(RASH1)),
    zp_ctl : setText (tostring(RASH2)),
    transp_ctl : setText (tostring(RASH3)),
    nalog_ctl : setText (tostring(RASH4)),
    arenda_ctl : setText (tostring(RASH5)),
    rekl_ctl : setText (tostring(RASH6)),
    rashsem_ctl : setText (tostring(RASH7)),
    prrash_ctl : setText (tostring(RASH8)),
    kreditor_ctl : setText (KR),
    sum_ctl : setText (tostring(SUMZ)),
    sum2_ctl : setText (tostring(SUMP)),
    fail.
    info (Name) :- nazv_ctl : setText (Name), !.   

% редактирование непринятой заявки
predicates
    onEditClick : button::clickResponder.
clauses
    onEditClick(_Source) = button::defaultAction :-
        reconsult ("yurdb.txt"), 
        obnul,
        nazv1_ctl : setVisible (true),
        nazv_ctl : setVisible (false), 
        print.   

% выбор из листбокса
predicates
    onNazv1SelectionChanged : listControl::selectionChangedListener.
clauses
    onNazv1SelectionChanged(_Source):-
      Name = nazv1_ctl : getText(),
      info (Name).

% This code is maintained automatically, do not update it manually. 11:35:09-2.5.2010
facts
    summa_ctl : editControl.
    srok_ctl : editControl.
    okusl_ctl : editControl.
    real_ctl : editControl.
    goal_ctl : editControl.
    prdoh_ctl : editControl.
    dkap_ctl : editControl.
    adr1_ctl : editControl.
    fio_ctl : editControl.
    chet_ctl : editControl.
    nazv_ctl : editControl.
    nalog_ctl : editControl.
    prrash_ctl : editControl.
    kreditor_ctl : editControl.
    deyat_ctl : listButton.
    rashsem_ctl : editControl.
    rassm_ctl : button.
    dr2_ctl : editControl.
    den2_ctl : listButton.
    mes2_ctl : listButton.
    vidkr_ctl : listButton.
    zak_ctl : editControl.
    zp_ctl : editControl.
    transp_ctl : editControl.
    arenda_ctl : editControl.
    rekl_ctl : editControl.
    sum_ctl : editControl.
    sum2_ctl : editControl.
    zalog_ctl : listButton.
    kolsotr_ctl : editControl.
    nazv1_ctl : listButton.
    edit_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Новый клиент - юридическое лицо~"),
        setRect(rct(50,40,662,260)),
        setDecoration(titlebar([closebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        summa_ctl := editControl::new(This),
        summa_ctl:setText(""),
        summa_ctl:setPosition(108, 144),
        summa_ctl:setWidth(84),
        summa_ctl:setHeight(12),
        summa_ctl:setMultiLine(),
        srok_ctl := editControl::new(This),
        srok_ctl:setText(""),
        srok_ctl:setPosition(108, 158),
        srok_ctl:setWidth(84),
        okusl_ctl := editControl::new(This),
        okusl_ctl:setText(""),
        okusl_ctl:setPosition(312, 102),
        okusl_ctl:setWidth(84),
        real_ctl := editControl::new(This),
        real_ctl:setText(""),
        real_ctl:setPosition(312, 88),
        real_ctl:setWidth(84),
        real_ctl:setHeight(12),
        real_ctl:setMultiLine(),
        goal_ctl := editControl::new(This),
        goal_ctl:setText(""),
        goal_ctl:setPosition(108, 130),
        goal_ctl:setWidth(84),
        goal_ctl:setHeight(12),
        goal_ctl:setMultiLine(),
        prdoh_ctl := editControl::new(This),
        prdoh_ctl:setText(""),
        prdoh_ctl:setPosition(312, 116),
        prdoh_ctl:setWidth(84),
        dkap_ctl := editControl::new(This),
        dkap_ctl:setText(""),
        dkap_ctl:setPosition(108, 116),
        dkap_ctl:setWidth(84),
        adr1_ctl := editControl::new(This),
        adr1_ctl:setText(""),
        adr1_ctl:setPosition(108, 60),
        adr1_ctl:setWidth(84),
        fio_ctl := editControl::new(This),
        fio_ctl:setText(""),
        fio_ctl:setPosition(108, 102),
        fio_ctl:setWidth(84),
        chet_ctl := editControl::new(This),
        chet_ctl:setText(""),
        chet_ctl:setPosition(108, 74),
        chet_ctl:setWidth(84),
        nazv_ctl := editControl::new(This),
        nazv_ctl:setText(""),
        nazv_ctl:setPosition(108, 46),
        nazv_ctl:setWidth(84),
        nalog_ctl := editControl::new(This),
        nalog_ctl:setText(""),
        nalog_ctl:setPosition(516, 46),
        nalog_ctl:setWidth(84),
        prrash_ctl := editControl::new(This),
        prrash_ctl:setText(""),
        prrash_ctl:setPosition(516, 102),
        prrash_ctl:setWidth(84),
        kreditor_ctl := editControl::new(This),
        kreditor_ctl:setText(""),
        kreditor_ctl:setPosition(516, 130),
        kreditor_ctl:setWidth(84),
        deyat_ctl := listButton::new(This),
        deyat_ctl:setPosition(108, 88),
        deyat_ctl:setWidth(84),
        deyat_ctl:setMaxDropDownRows(4),
        deyat_ctl:setSort(false),
        rashsem_ctl := editControl::new(This),
        rashsem_ctl:setText(""),
        rashsem_ctl:setPosition(516, 88),
        rashsem_ctl:setWidth(84),
        rassm_ctl := button::new(This),
        rassm_ctl:setText("Рассмотреть заявку"),
        rassm_ctl:setPosition(312, 196),
        rassm_ctl:setSize(108, 16),
        rassm_ctl:setClickResponder(onRassmClick),
        dr2_ctl := editControl::new(This),
        dr2_ctl:setText(""),
        dr2_ctl:setPosition(576, 172),
        dr2_ctl:setWidth(24),
        den2_ctl := listButton::new(This),
        den2_ctl:setPosition(516, 172),
        den2_ctl:setWidth(24),
        den2_ctl:setMaxDropDownRows(4),
        den2_ctl:setSort(false),
        mes2_ctl := listButton::new(This),
        mes2_ctl:setPosition(540, 172),
        mes2_ctl:setWidth(36),
        mes2_ctl:setMaxDropDownRows(4),
        mes2_ctl:setSort(false),
        vidkr_ctl := listButton::new(This),
        vidkr_ctl:setPosition(108, 172),
        vidkr_ctl:setWidth(84),
        vidkr_ctl:setMaxDropDownRows(4),
        vidkr_ctl:setSort(false),
        zak_ctl := editControl::new(This),
        zak_ctl:setText(""),
        zak_ctl:setPosition(312, 144),
        zak_ctl:setWidth(84),
        zp_ctl := editControl::new(This),
        zp_ctl:setText(""),
        zp_ctl:setPosition(312, 158),
        zp_ctl:setWidth(84),
        transp_ctl := editControl::new(This),
        transp_ctl:setText(""),
        transp_ctl:setPosition(312, 172),
        transp_ctl:setWidth(84),
        arenda_ctl := editControl::new(This),
        arenda_ctl:setText(""),
        arenda_ctl:setPosition(516, 60),
        arenda_ctl:setWidth(84),
        rekl_ctl := editControl::new(This),
        rekl_ctl:setText(""),
        rekl_ctl:setPosition(516, 74),
        rekl_ctl:setWidth(84),
        sum_ctl := editControl::new(This),
        sum_ctl:setText(""),
        sum_ctl:setPosition(516, 144),
        sum_ctl:setWidth(84),
        sum2_ctl := editControl::new(This),
        sum2_ctl:setText(""),
        sum2_ctl:setPosition(516, 158),
        sum2_ctl:setWidth(84),
        zalog_ctl := listButton::new(This),
        zalog_ctl:setPosition(312, 46),
        zalog_ctl:setWidth(84),
        zalog_ctl:setMaxDropDownRows(4),
        zalog_ctl:setSort(false),
        kolsotr_ctl := editControl::new(This),
        kolsotr_ctl:setText(""),
        kolsotr_ctl:setPosition(312, 60),
        kolsotr_ctl:setWidth(84),
        kolsotr_ctl:setHeight(12),
        kolsotr_ctl:setMultiLine(),
        nazv1_ctl := listButton::new(This),
        nazv1_ctl:setPosition(108, 46),
        nazv1_ctl:setWidth(84),
        nazv1_ctl:setMaxDropDownRows(4),
        nazv1_ctl:setVScroll(false),
        nazv1_ctl:setSort(false),
        nazv1_ctl:addSelectionChangedListener(onNazv1SelectionChanged),
        edit_ctl := button::new(This),
        edit_ctl:setText("Редактировать заявку"),
        edit_ctl:setPosition(188, 196),
        edit_ctl:setSize(112, 16),
        edit_ctl:setClickResponder(onEditClick),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Анкета-заявление на предоставление кредита юридическому лицу"),
        StaticText_ctl:setPosition(184, 6),
        StaticText_ctl:setSize(238, 16),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Название предприятия"),
        StaticText1_ctl:setPosition(12, 46),
        StaticText1_ctl:setSize(84, 12),
        ФИО1_ctl = textControl::new(This),
        ФИО1_ctl:setText("Расчётный счёт"),
        ФИО1_ctl:setPosition(12, 74),
        ФИО1_ctl:setSize(84, 12),
        ФИО2_ctl = textControl::new(This),
        ФИО2_ctl:setText("Учредитель (Ф. И. О.)"),
        ФИО2_ctl:setPosition(12, 102),
        ФИО2_ctl:setSize(84, 12),
        ФИО3_ctl = textControl::new(This),
        ФИО3_ctl:setText("Юридический адрес"),
        ФИО3_ctl:setPosition(12, 60),
        ФИО3_ctl:setSize(84, 12),
        ФИО4_ctl = textControl::new(This),
        ФИО4_ctl:setText("Доля в капитале (%)"),
        ФИО4_ctl:setPosition(12, 116),
        ФИО4_ctl:setSize(84, 12),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Общие сведения о клиенте и условия кредитования"),
        StaticText2_ctl:setPosition(12, 26),
        StaticText2_ctl:setSize(188, 14),
        ДатаРождения_ctl = textControl::new(This),
        ДатаРождения_ctl:setText("На срок (мес)"),
        ДатаРождения_ctl:setPosition(12, 158),
        ДатаРождения_ctl:setSize(84, 12),
        ФИО5_ctl = textControl::new(This),
        ФИО5_ctl:setText("Кредит на сумму *"),
        ФИО5_ctl:setPosition(12, 144),
        ФИО5_ctl:setSize(84, 12),
        StaticText4_ctl = textControl::new(This),
        StaticText4_ctl:setText("Дополнительные сведения"),
        StaticText4_ctl:setPosition(268, 26),
        StaticText4_ctl:setSize(96, 14),
        КредитВСумме_ctl = textControl::new(This),
        КредитВСумме_ctl:setText("Реализация товаров"),
        КредитВСумме_ctl:setPosition(216, 88),
        КредитВСумме_ctl:setSize(84, 12),
        НаСрокВМесяцах_ctl = textControl::new(This),
        НаСрокВМесяцах_ctl:setText("Оказание услуг"),
        НаСрокВМесяцах_ctl:setPosition(216, 102),
        НаСрокВМесяцах_ctl:setSize(84, 12),
        АдресПроживания_ctl = textControl::new(This),
        АдресПроживания_ctl:setText("Реклама"),
        АдресПроживания_ctl:setPosition(420, 74),
        АдресПроживания_ctl:setSize(83, 12),
        КредитВСумме1_ctl = textControl::new(This),
        КредитВСумме1_ctl:setText("Цель кредита"),
        КредитВСумме1_ctl:setPosition(12, 130),
        КредитВСумме1_ctl:setSize(84, 12),
        Должность_ctl = textControl::new(This),
        Должность_ctl:setText("Транспорт"),
        Должность_ctl:setPosition(216, 172),
        Должность_ctl:setSize(84, 12),
        ЖильёПоМестуПроживания_ctl = textControl::new(This),
        ЖильёПоМестуПроживания_ctl:setText("Прочие доходы"),
        ЖильёПоМестуПроживания_ctl:setPosition(216, 116),
        ЖильёПоМестуПроживания_ctl:setSize(84, 12),
        НаТекущемМесте_ctl = textControl::new(This),
        НаТекущемМесте_ctl:setText("Налоги"),
        НаТекущемМесте_ctl:setPosition(420, 46),
        НаТекущемМесте_ctl:setSize(84, 12),
        НаТекущемМесте2_ctl = textControl::new(This),
        НаТекущемМесте2_ctl:setText("Прочие расходы"),
        НаТекущемМесте2_ctl:setPosition(420, 102),
        НаТекущемМесте2_ctl:setSize(84, 12),
        ДоходСемьи_ctl = textControl::new(This),
        ДоходСемьи_ctl:setText("Кредитор"),
        ДоходСемьи_ctl:setPosition(420, 130),
        ДоходСемьи_ctl:setSize(84, 12),
        ТипДолжности_ctl = textControl::new(This),
        ТипДолжности_ctl:setText("Кол-во сотрудников"),
        ТипДолжности_ctl:setPosition(216, 60),
        ТипДолжности_ctl:setSize(84, 12),
        ТипДолжности1_ctl = textControl::new(This),
        ТипДолжности1_ctl:setText("Вид деятельности"),
        ТипДолжности1_ctl:setPosition(12, 88),
        ТипДолжности1_ctl:setSize(84, 12),
        НаТекущемМесте1_ctl = textControl::new(This),
        НаТекущемМесте1_ctl:setText("Расходы на семью"),
        НаТекущемМесте1_ctl:setPosition(420, 88),
        НаТекущемМесте1_ctl:setSize(84, 12),
        ДатаРождения1_ctl = textControl::new(This),
        ДатаРождения1_ctl:setText("Дата "),
        ДатаРождения1_ctl:setPosition(420, 172),
        ДатаРождения1_ctl:setSize(84, 12),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("*  - здесь и далее в тыс. руб.\n** - выплата в месяц"),
        StaticText3_ctl:setPosition(432, 196),
        StaticText3_ctl:setSize(172, 18),
        ДоляВКапитале_ctl = textControl::new(This),
        ДоляВКапитале_ctl:setText("Вид кредита"),
        ДоляВКапитале_ctl:setPosition(12, 172),
        ДоляВКапитале_ctl:setSize(84, 12),
        КраткосрочОбязВа_ctl = textControl::new(This),
        КраткосрочОбязВа_ctl:setText("Закупка товаров"),
        КраткосрочОбязВа_ctl:setPosition(216, 144),
        КраткосрочОбязВа_ctl:setSize(84, 12),
        КраткосрочОбязВа1_ctl = textControl::new(This),
        КраткосрочОбязВа1_ctl:setText("З/П работников"),
        КраткосрочОбязВа1_ctl:setPosition(217, 158),
        КраткосрочОбязВа1_ctl:setSize(84, 12),
        Налоги_ctl = textControl::new(This),
        Налоги_ctl:setText("Аренда"),
        Налоги_ctl:setPosition(420, 60),
        Налоги_ctl:setSize(84, 12),
        StaticText5_ctl = textControl::new(This),
        StaticText5_ctl:setText("Доходы"),
        StaticText5_ctl:setPosition(292, 74),
        StaticText5_ctl:setSize(28, 10),
        Доходы_ctl = textControl::new(This),
        Доходы_ctl:setText("Расходы"),
        Доходы_ctl:setPosition(292, 130),
        Доходы_ctl:setSize(32, 10),
        Расходы_ctl = textControl::new(This),
        Расходы_ctl:setText("Текущая ссудная задолженность"),
        Расходы_ctl:setPosition(452, 116),
        Расходы_ctl:setSize(120, 10),
        Кредитор_ctl = textControl::new(This),
        Кредитор_ctl:setText("Сумма задолженности"),
        Кредитор_ctl:setPosition(420, 144),
        Кредитор_ctl:setSize(84, 12),
        СуммаЗадолженности_ctl = textControl::new(This),
        СуммаЗадолженности_ctl:setText("Сумма погашения **"),
        СуммаЗадолженности_ctl:setPosition(420, 158),
        СуммаЗадолженности_ctl:setSize(84, 12),
        ВидКредита_ctl = textControl::new(This),
        ВидКредита_ctl:setText("Залог"),
        ВидКредита_ctl:setPosition(216, 46),
        ВидКредита_ctl:setSize(84, 12).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement formNewClientYur
