/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formNewClientFiz
    inherits formWindow
    open core, vpiDomains

constants
    className = "formNewClientFiz/formNewClientFiz".
    classVersion = "".
    
clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

% предикаты в БД
class facts - fizDB
  person : (string Name, string Pol, integer Den1, string Mes1, integer God1, string Mr, string Pasp, 
                string Adr1, string Adr2, string Mrab, string Dolzhn, string Rdeyat, string Goal, 
                integer Summa, integer Srok, integer Den2, string Mes2, integer God2).  
  person1 : (string Name, string Pol, integer Den1, string Mes1, integer God1, string Mr, string Pasp, 
                string Adr1, string Adr2, string Goal, integer Summa, integer Srok, string Zanyat, string Mrab, 
                string Rdeyat, string Dolzhn, string Tdolzhn, string Ostazh, integer Tstazh, string Sem, 
                integer Kolizhn, integer Drkr, string Zhil, integer Doh, integer Dohsem, integer Dopdoh,
                string Odop, integer Rash, string Nedv, string Avt, string Dopdoc).     
  
% чтение данных
predicates
    reconsult : (string FileName).   
clauses
   reconsult (Filename) :-                       
                 retractFactDb (fizDB),
                 file :: consult (FileName, fizDB).
                 
% рассмотрение заявки
predicates
    onRassmClick : button :: clickResponder.
clauses
    onRassmClick(_Source) = button :: defaultAction :-
      % чтение данных из формы
      FIO =  fio_ctl : getText(),                                         % Фамилия, Имя, Отчество
      M = m_ctl : getRadioState(),                                    % Определение пола
      if ( M =  radioButton :: checked() ) 		
        then POL = "мужский"
        else POL = "женский"
        end if,       
      hasDomain (integer, D1),    
      D1 = toterm (den_ctl : getText()),                             % День рождения                                   
      M1 = mes_ctl : getText(),                                         % Месяц рождения                                    
      hasDomain(integer, G1),    
      G1 = toterm (dr_ctl : getText()),                               % Год рождения
      MR = mr_ctl : getText(),                                           % Место рождения
      PASP = pasport_ctl : getText(),                                 % Серия и номер паспорта
      ADR1 = adr1_ctl : getText(),                                     % Адрес регистрации
      ADR2 = adr2_ctl : getText(),  			                       % Адрес проживания
      MRAB = mrab_ctl : getText(),			                          % Место работы
      DOLZHN = dolzhn_ctl : getText(),    		                     % Должность  
      GOAL = goal_ctl : getText(),   			                        % Цель кредита
      hasDomain(integer, SROK),    	
      SROK = toterm (srok_ctl : getText()),		                   % Срок
      hasDomain(integer, SUMMA),    
      SUMMA = toterm (summa_ctl : getText()),		           % Сумма
      %
      ZANYAT = zanyat_ctl : getSelectedIndices(),
      RDEYAT = rdeyat_ctl : getText(),
      TDOLZHN = tdolzhn_ctl : getSelectedIndices(),
      OSTAZH = ostazh_ctl : getSelectedIndices(),
      hasDomain(integer, TSTAZH),    
      TSTAZH = toterm (tstazh_ctl : getText()),
      SEM = sem_ctl : getSelectedIndices(),
       if ( SEM=[1] or SEM=[2] ), !
                      then SUPR = 1
                      else SUPR = 0
                      end if,
      hasDomain(integer, KOLIZH),    
      KOLIZH = toterm (kolizh_ctl : getText()),
      D = yes_ctl : getRadioState(),                                  
      if ( D =  radioButton :: checked() ) 		
        then DRKR = 1
        else DRKR = 0
        end if,    
      ZHIL = zhile_ctl : getSelectedIndices(),
      hasDomain(integer, DOH),    
      DOH = toterm (doh_ctl : getText()),
      hasDomain(integer, DOHSEM),    
      DOHSEM = toterm (dohsem_ctl : getText()),  
      hasDomain(integer, DOP),    
      DOP = toterm (dop_ctl : getText()),
      ODOP = odop_ctl : getSelectedIndices(),
      hasDomain(integer, RASH),    
      RASH = toterm (rash_ctl : getText()),  
      NEDV = nedv_ctl : getSelectedIndices(),
      AVT = avt_ctl : getSelectedIndices(),
      DOPDOC = dopdoc_ctl : getSelectedIndices(),
      hasDomain (integer, D2),    
      D2 = toterm (den2_ctl : getText()),                                                     
      M2 = mes2_ctl : getText(),                                         
      hasDomain(integer, G2),    
      G2 = toterm (dr2_ctl : getText()),   
   % формирование ответа   
     result (G1, G2, DOH, TSTAZH, SUPR, DOHSEM, DOP, RASH, SUMMA, SROK, KOLIZH, ZANYAT, 
                OSTAZH, ZHIL, TDOLZHN, ADR1, ADR2, DRKR, NEDV, AVT, ODOP, DOPDOC, RES, OTV),  
    %     
      if ( M =  radioButton :: checked() ) 
        then stdio :: write ( "Уважаемый  ")
        else  stdio :: write ( "Уважаемая  ")   
        end if,   
     stdio :: write (FIO, "!\n", OTV, "\n"), 
   % запись в файл    
     reconsult ("fizdb.txt"),  
      if (RES = 1) 
        then 
        (       
           if (person1 (FIO,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)), !
             then 
             (
                 retract (person1 (FIO,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_))                          
             )             
             end if,           
           asserta (person (FIO, POL, D1, M1, G1, MR, PASP, ADR1, ADR2, MRAB, DOLZHN, RDEYAT, GOAL, SUMMA, SROK, D2, M2, G2) ),
           print (FIO, POL, M1, MR, PASP, ADR1, ADR2, GOAL, MRAB, RDEYAT, DOLZHN, M2)  
        )   
        else
        (   
           if (not(person1 (FIO,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)) )
             then assertz (person1(FIO, POL, D1, M1, G1, MR, PASP, ADR1, ADR2, GOAL, SUMMA,
                        SROK, zanyat_ctl : getText(), MRAB, RDEYAT, DOLZHN, tdolzhn_ctl : getText(), 
                        ostazh_ctl : getText(), TSTAZH, sem_ctl : getText(), KOLIZH, DRKR, 
                        zhile_ctl : getText(), DOH, DOHSEM, DOP, odop_ctl : getText(), RASH,
                        nedv_ctl : getText(), avt_ctl : getText(), dopdoc_ctl : getText() ))     
             end if 
        )        
        end if,   
    % сохранение результата
      file :: save ("fizdb.txt", fizDB),  
    % очистка полей формы    
      fio1_ctl : setVisible (false), 
      fio_ctl : setVisible (true),
      obnul,
        !.%CUT
  onRassmClick(_Source) = button :: defaultAction. % catch all. If the first clause fails, it comes here

% рассмотрение заявки и результат
predicates
  result :  (integer G1, integer G2, integer Doh, integer Tstazh, integer Supr, integer Dohsem, integer Dop, integer Rash,
               integer Summa, integer Srok, integer Kolizh, positive* Zanyat, positive* Ostazh, positive* Zhil, positive* Tdolzhn, 
               string Adr1, string Adr2, integer Drkr, positive* Nedv, positive* Avt, positive* Odop, positive* Dopdoc, integer Res, string Otv)  
               multi (i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,o,o). 
clauses 
  result (G1, G2,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0, "Ваш возраст менее 21 года / более 65 лет") :- 
     G2-G1<21 or G2-G1>65.
  result (_,_,Doh,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0, "Вы имеете постоянный источник дохода ниже 15 тысяч рублей в месяц") :- 
     Doh < 15000.
  result (_,_,_,Tstazh,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0, "Ваш непрерывный трудовой стаж в компании составляет  менее 12 месяцев") :- 
     Tstazh < 12.
  result (_,_,Doh,_,Supr,Dohsem,Dop,Rash,Summa,Srok,Kolizh,_,_,_,_,_,_,_,_,_,_,_,0, "Ваших ежемесячных доходов недостаточно для погашения кредита") :-
     (Doh + Dohsem + Dop - Rash - Summa/Srok)  /  (1 + Supr + Kolizh) < 5200. 
  result (_,_,_,_,_,_,_,_,_,_,_,Zanyat,Ostazh,Zhil,Tdolzhn,Adr1,Adr2,Drkr,Nedv,Avt,Odop,_,0,  "Заключение договора с Вами - слишком большой риск для нашего банка") :-
      (Zanyat = [4], Ostazh <> [4], (Zhil = [3] or Zhil = [5])) or
      (Tdolzhn = [4], (Ostazh = [1] or Ostazh = [2]), (Zhil = [3] or Zhil = [5]), Adr1 <> Adr2) or
      (Drkr = 1, Nedv = [2], Avt = [2]) or
      (Zanyat = [4], (Odop = [1] or Odop > [8])).
  result (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Dopdoc,1, "Для получения кредита Вам необходимо предоставить документ (помимо паспорта), подтверждающий личность") :- 
      Dopdoc = [6].     
  result (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Res, Otv) :- 
     Res = 1, 
     Otv = "Для получения кредита обратитесь с заявлением (1.txt) в любое отделение банка. Перечень необходимых документов находится в соответствующем разделе".  
  
% формирование выходного документа
predicates
  print : (string Fio, string Pol, string Mes1, string Mr, string Pasp, string Sdr1, string Adr2, string Goal, string Mrab, string Rdeyat, string Dolzhn, string Mes2).
clauses
  print (FIO, POL, M1, MR, PASP, ADR1, ADR2, GOAL, MRAB, RDEYAT, DOLZHN, M2) :-
           ZAYA1 = string :: concat ("\tЗАЯВЛЕНИЕ:\nФ. И. О. : ", FIO, "\nПол: ", POL, "\nДата рождения: ", den_ctl : getText()),
           ZAYA2 = string :: concat (ZAYA1, " ",  M1, " ", dr_ctl : getText(), "\nМесто рождения: "),
           ZAYA3 = string :: concat (ZAYA2, MR, "\nСерия и номер паспорта: ", PASP, "\nАдрес регистрации: ", ADR1),
           ZAYA4 = string :: concat (ZAYA3, "\nАдрес проживания: ", ADR2, "\nЦель кредита: ", GOAL, "\nКредит на сумму: "), 
           ZAYA5 = string :: concat (ZAYA4, summa_ctl : getText(), "\nНа срок: ", srok_ctl : getText(), " месяцев\nТип занятости: ", zanyat_ctl : getText()),
           ZAYA6 = string :: concat (ZAYA5, "\nМесто работы: ", MRAB, "\nРод деятельности: ", RDEYAT, "\nДолжность: "),
           ZAYA7 = string :: concat (ZAYA6, DOLZHN, "\nТип должности: ", tdolzhn_ctl : getText(), "\nОбщий трудовой стаж: ", ostazh_ctl : getText()),
           ZAYA8 = string :: concat (ZAYA7, "\nСтаж на текущем месте: ", tstazh_ctl : getText(), "\nСемейное положение: ", sem_ctl : getText(), "\nКоличество иждивенцев: "),
           ZAYA9 = string :: concat (ZAYA8, kolizh_ctl : getText(), "\nЖильё по месту фактического проживания: ", zhile_ctl : getText(), "\nДоход клиента: ", doh_ctl : getText()),
           ZAYA10 = string :: concat (ZAYA9, "\nДоход семьи: ", dohsem_ctl : getText(), "\nДополнительный доход: ", dop_ctl : getText(), "\nОписание доп. дохода: "),
           ZAYA11 = string :: concat (ZAYA10, odop_ctl : getText(), "\nРасходы: ", rash_ctl : getText(), "\nНедвижимость: ", nedv_ctl : getText()),
           ZAYA12 = string :: concat (ZAYA11, "\nАвтомобиль: ", avt_ctl : getText(), "\nДополнительный документ: ", dopdoc_ctl : getText(), "\nДата: "),
           ZAYA13 = string :: concat (ZAYA12, den2_ctl : getText(), " ", M2, " ", dr2_ctl : getText()),
           file :: writeString ("1.txt", ZAYA13 , true).

% обнуление полей формы    
predicates
    obnul : ().
clauses
    obnul () :-
      fio_ctl : setText (""),
      m_ctl : setRadioState (radioButton :: unChecked()),
      zh_ctl : setRadioState (radioButton :: unChecked()),
      den_ctl : selectAt(0,true), 
      mes_ctl  : selectAt(0, true), 
      zanyat_ctl : selectAt(0, true), 
      rdeyat_ctl : selectAt(0, true), 
      tdolzhn_ctl : selectAt(0, true), 
      ostazh_ctl : selectAt(0, true), 
      sem_ctl : selectAt(0, true), 
      zhile_ctl : selectAt(0, true), 
      odop_ctl : selectAt(0, true), 
      nedv_ctl : selectAt(0, true), 
      avt_ctl : selectAt(0, true), 
      dopdoc_ctl : selectAt(0, true), 
      den2_ctl : selectAt(0, true), 
      mes2_ctl : selectAt(0, true),   
      dr_ctl : setText (""),
      mr_ctl : setText (""),
      pasport_ctl : setText (""),
      adr1_ctl : setText (""),
      adr2_ctl : setText (""),
      goal_ctl : setText (""),
      summa_ctl : setText (""),
      srok_ctl : setText (""),
      mrab_ctl : setText (""),
      dolzhn_ctl : setText (""),
      tstazh_ctl : setText (""),
      kolizh_ctl : setText (""),
      yes_ctl : setRadioState (radioButton :: unChecked()),
      no_ctl : setRadioState (radioButton :: unChecked()),
      doh_ctl : setText (""),
      dohsem_ctl : setText (""),
      dop_ctl : setText (""),
      rash_ctl : setText (""),
      dr2_ctl : setText ("").                          
    
% при открытии формы  
predicates
    onShow : window::showListener.
    listAdd : ().
clauses
    onShow(_Source, _Data) :-
      fio1_ctl : setVisible (false), 
      fio_ctl : setVisible (true),
      listAdd.

% добавление полей в листбоксы      
clauses
    listAdd () :-
      den_ctl : addList (["~","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]),
      mes_ctl : addList (["~","января","февраля","марта","апреля","мая","июня","июля","августа","сентября","октября","ноября","декабря"]),
      den2_ctl : addList (["~","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]),
      mes2_ctl : addList (["~","января","февраля","марта","апреля","мая","июня","июля","августа","сентября","октября","ноября","декабря"]),
      zanyat_ctl : addList (["~","работаю по найму полный рабочий день/служу","работаю по найму неполный рабочий день","собственное дело","не работаю"]),
      rdeyat_ctl : addList (["~","участие в основной деятельности","реклама/маркетинг","бухгалтерия/финансы",
                                     "кадровая служба/секретариат","юридическая служба","техническое обеспечение", "другое"]),
      tdolzhn_ctl : addList (["~","предприниматель/владелец бизнеса","руководство организации","руководство подразделения","неруководящий работник", "другое"]),
      ostazh_ctl : addList (["~","<1 года","1-2 года","2-5 лет",">5 лет"]),
      sem_ctl : addList (["~","женат/замужем","гражданский брак","разведены","вдовец/вдова","никогда в браке не состояли"]),      
      zhile_ctl : addList (["~","целиком является Вашей собственностью","является Вашей собственностью совместно с иными лицами","Вы снимаете данное жильё",
                                  "Вы живёте в неприватизированном жилье","проживаете у родственников/друзей"]),
      odop_ctl : addList (["~","премия/бонус","пенсия","алименты","сдача квартиры в аренду","работа по совместительству","репетиторство","доходы от ценных бумаг",
                                   "частный извоз","помощь родственников","другое"]),
      nedv_ctl : addList (["~","есть","нет"]),   
      avt_ctl : addList (["~","есть","нет"]),    
      dopdoc_ctl : addList (["~","заграничный паспорт","водительское удостоверение","страховое свидетельство пенсионного фонда",
                                      "полис медицинского страхования","ИНН","нет"]).

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
     fio1_ctl : clearAll(),
     person1 (Name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),
     fio1_ctl : add (Name),
     fail.
     print () :- !.

clauses
  info (Name) :-
    person1(Name, POL, D1, M1, G1, MR, PASP, ADR1, ADR2, GOAL, SUMMA,
                        SROK, ZANYAT, MRAB, RDEYAT, DOLZHN, TDOLZHN, OSTAZH,
                        TSTAZH,  SEM, KOLIZH, DRKR, ZHIL, DOH, DOHSEM, DOP, 
                        ODOP, RASH, NEDV, AVT, DOPDOC),
    fio_ctl : setText (Name),
    if (POL = "мужской")
      then m_ctl : setRadioState  (radioButton :: checked())
      else zh_ctl : setRadioState  (radioButton :: checked())
      end if,
    den_ctl : selectAt (D1, true),
    nomer (mes_ctl : getAll(), M1, 0, R1),   
    mes_ctl : selectAt (R1, true),
    nomer (zanyat_ctl : getAll(), ZANYAT, 0, R2),   
    zanyat_ctl : selectAt (R2, true),
    nomer (rdeyat_ctl : getAll(), RDEyAT, 0, R3),   
    rdeyat_ctl : selectAt (R3, true),
    nomer (tdolzhn_ctl : getAll(), TDOLZHN, 0, R4),   
    tdolzhn_ctl : selectAt (R4, true),
    nomer (ostazh_ctl : getAll(), OSTAZH, 0, R5),      
    ostazh_ctl : selectAt (R5, true),
    nomer (sem_ctl : getAll(), SEM, 0, R6),   
    sem_ctl : selectAt (R6, true),
    nomer (zhile_ctl : getAll(), ZHIL, 0, R7),   
    zhile_ctl : selectAt (R7, true),
    nomer (odop_ctl : getAll(), ODOP, 0, R8),   
    odop_ctl : selectAt (R8, true),
    nomer (nedv_ctl : getAll(), NEDV, 0, R9),   
    nedv_ctl : selectAt (R9, true),
    nomer (avt_ctl : getAll(), AVT, 0, R10),   
    avt_ctl : selectAt (R10, true),
    nomer (dopdoc_ctl : getAll(), DOPDOC, 0, R11),   
    dopdoc_ctl : selectAt (R11, true),
    dr_ctl : setText (tostring(G1)),
    mr_ctl : setText (MR),
    pasport_ctl : setText (PASP),
    adr1_ctl : setText (ADR1),
    adr2_ctl : setText (ADR2),
    goal_ctl : setText (GOAL),
    summa_ctl : setText (tostring(SUMMA)),
    srok_ctl : setText (tostring(SROK)),
    mrab_ctl : setText (MRAB),
    dolzhn_ctl : setText (DOLZHN),
    tstazh_ctl : setText (tostring(TSTAZH)),
    kolizh_ctl : setText (tostring(KOLIZH)),
    if (DRKR = 1)
      then yes_ctl : setRadioState  (radioButton :: checked())
      else no_ctl   : setRadioState  (radioButton :: checked())
      end if,
    doh_ctl : setText (tostring(DOH)),
    dohsem_ctl : setText (tostring(DOHSEM)),
    rash_ctl : setText (tostring(RASH)),
    dop_ctl : setText (tostring(DOP)),
    fail.
    info (Name) :- fio_ctl : setText (Name), !.    

% редактирование непринятой заявки
predicates
    onРассмотретьЗаявкуClick : button::clickResponder.
clauses
    onРассмотретьЗаявкуClick(_Source) = button::defaultAction:-
      reconsult ("fizdb.txt"), 
      obnul, 
      fio1_ctl : setVisible (true), 
      fio_ctl : setVisible (false), 
      print.   

% выбор из листбокса
predicates
    onFio1SelectionChanged : listControl::selectionChangedListener.
clauses
    onFio1SelectionChanged(_Source):-
      Name = fio1_ctl : getText(),
      info (Name).

% This code is maintained automatically, do not update it manually. 11:11:30-2.5.2010
facts
    summa_ctl : editControl.
    srok_ctl : editControl.
    dolzhn_ctl : editControl.
    mrab_ctl : editControl.
    goal_ctl : editControl.
    tstazh_ctl : editControl.
    sem_ctl : listButton.
    zhile_ctl : listButton.
    adr2_ctl : editControl.
    adr1_ctl : editControl.
    pasport_ctl : editControl.
    mr_ctl : editControl.
    dr_ctl : editControl.
    fio_ctl : editControl.
    tdolzhn_ctl : listButton.
    kolizh_ctl : editControl.
    dohsem_ctl : editControl.
    rash_ctl : editControl.
    dop_ctl : editControl.
    odop_ctl : listButton.
    ostazh_ctl : listButton.
    zanyat_ctl : listButton.
    rdeyat_ctl : listButton.
    doh_ctl : editControl.
    dopdoc_ctl : listButton.
    rassm_ctl : button.
    nedv_ctl : listButton.
    avt_ctl : listButton.
    m_ctl : radioButton.
    zh_ctl : radioButton.
    yes_ctl : radioButton.
    no_ctl : radioButton.
    den_ctl : listButton.
    mes_ctl : listButton.
    dr2_ctl : editControl.
    den2_ctl : listButton.
    mes2_ctl : listButton.
    edit_ctl : button.
    fio1_ctl : listButton.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Новый клиент - физическое лицо~"),
        setRect(rct(50,40,662,260)),
        setDecoration(titlebar([closebutton(),minimizebutton()])),
        setBorder(thinBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        summa_ctl := editControl::new(This),
        summa_ctl:setText(""),
        summa_ctl:setPosition(108, 158),
        summa_ctl:setWidth(84),
        summa_ctl:setHeight(12),
        summa_ctl:setMultiLine(),
        srok_ctl := editControl::new(This),
        srok_ctl:setText(""),
        srok_ctl:setPosition(108, 172),
        srok_ctl:setWidth(84),
        dolzhn_ctl := editControl::new(This),
        dolzhn_ctl:setText(""),
        dolzhn_ctl:setPosition(312, 88),
        dolzhn_ctl:setWidth(84),
        mrab_ctl := editControl::new(This),
        mrab_ctl:setText(""),
        mrab_ctl:setPosition(312, 60),
        mrab_ctl:setWidth(84),
        mrab_ctl:setHeight(12),
        mrab_ctl:setMultiLine(),
        goal_ctl := editControl::new(This),
        goal_ctl:setText(""),
        goal_ctl:setPosition(108, 144),
        goal_ctl:setWidth(84),
        goal_ctl:setHeight(12),
        goal_ctl:setMultiLine(),
        tstazh_ctl := editControl::new(This),
        tstazh_ctl:setText(""),
        tstazh_ctl:setPosition(312, 130),
        tstazh_ctl:setWidth(84),
        sem_ctl := listButton::new(This),
        sem_ctl:setPosition(312, 144),
        sem_ctl:setWidth(84),
        sem_ctl:setMaxDropDownRows(5),
        sem_ctl:setSort(false),
        zhile_ctl := listButton::new(This),
        zhile_ctl:setPosition(516, 46),
        zhile_ctl:setWidth(84),
        zhile_ctl:setMaxDropDownRows(5),
        zhile_ctl:setSort(false),
        adr2_ctl := editControl::new(This),
        adr2_ctl:setText(""),
        adr2_ctl:setPosition(108, 130),
        adr2_ctl:setWidth(84),
        adr1_ctl := editControl::new(This),
        adr1_ctl:setText(""),
        adr1_ctl:setPosition(108, 116),
        adr1_ctl:setWidth(84),
        pasport_ctl := editControl::new(This),
        pasport_ctl:setText(""),
        pasport_ctl:setPosition(108, 102),
        pasport_ctl:setWidth(84),
        mr_ctl := editControl::new(This),
        mr_ctl:setText(""),
        mr_ctl:setPosition(108, 88),
        mr_ctl:setWidth(84),
        dr_ctl := editControl::new(This),
        dr_ctl:setText(""),
        dr_ctl:setPosition(168, 74),
        dr_ctl:setWidth(24),
        fio_ctl := editControl::new(This),
        fio_ctl:setText(""),
        fio_ctl:setPosition(108, 46),
        fio_ctl:setWidth(84),
        tdolzhn_ctl := listButton::new(This),
        tdolzhn_ctl:setPosition(312, 102),
        tdolzhn_ctl:setWidth(84),
        tdolzhn_ctl:setMaxDropDownRows(5),
        tdolzhn_ctl:setSort(false),
        kolizh_ctl := editControl::new(This),
        kolizh_ctl:setText(""),
        kolizh_ctl:setPosition(312, 158),
        kolizh_ctl:setWidth(84),
        dohsem_ctl := editControl::new(This),
        dohsem_ctl:setText(""),
        dohsem_ctl:setPosition(516, 74),
        dohsem_ctl:setWidth(84),
        rash_ctl := editControl::new(This),
        rash_ctl:setText(""),
        rash_ctl:setPosition(516, 116),
        rash_ctl:setWidth(84),
        dop_ctl := editControl::new(This),
        dop_ctl:setText(""),
        dop_ctl:setPosition(516, 88),
        dop_ctl:setWidth(84),
        odop_ctl := listButton::new(This),
        odop_ctl:setPosition(516, 102),
        odop_ctl:setWidth(84),
        odop_ctl:setMaxDropDownRows(5),
        odop_ctl:setSort(false),
        ostazh_ctl := listButton::new(This),
        ostazh_ctl:setPosition(312, 116),
        ostazh_ctl:setWidth(84),
        ostazh_ctl:setMaxDropDownRows(5),
        ostazh_ctl:setSort(false),
        zanyat_ctl := listButton::new(This),
        zanyat_ctl:setPosition(312, 46),
        zanyat_ctl:setWidth(84),
        zanyat_ctl:setMaxDropDownRows(5),
        zanyat_ctl:setSort(false),
        rdeyat_ctl := listButton::new(This),
        rdeyat_ctl:setPosition(312, 74),
        rdeyat_ctl:setWidth(84),
        rdeyat_ctl:setMaxDropDownRows(5),
        rdeyat_ctl:setSort(false),
        doh_ctl := editControl::new(This),
        doh_ctl:setText(""),
        doh_ctl:setPosition(516, 60),
        doh_ctl:setWidth(84),
        dopdoc_ctl := listButton::new(This),
        dopdoc_ctl:setPosition(516, 158),
        dopdoc_ctl:setWidth(84),
        dopdoc_ctl:setMaxDropDownRows(5),
        dopdoc_ctl:setSort(false),
        rassm_ctl := button::new(This),
        rassm_ctl:setText("Рассмотреть заявку"),
        rassm_ctl:setPosition(312, 196),
        rassm_ctl:setSize(110, 16),
        rassm_ctl:setClickResponder(onRassmClick),
        nedv_ctl := listButton::new(This),
        nedv_ctl:setPosition(516, 130),
        nedv_ctl:setWidth(84),
        nedv_ctl:setMaxDropDownRows(5),
        avt_ctl := listButton::new(This),
        avt_ctl:setPosition(516, 144),
        avt_ctl:setWidth(84),
        avt_ctl:setMaxDropDownRows(5),
        m_ctl := radioButton::new(This),
        m_ctl:setText("муж"),
        m_ctl:setPosition(108, 60),
        m_ctl:setWidth(28),
        zh_ctl := radioButton::new(This),
        zh_ctl:setText("жен"),
        zh_ctl:setPosition(148, 60),
        zh_ctl:setWidth(28),
        GroupBox_ctl = groupBox::new(This),
        GroupBox_ctl:setText(""),
        GroupBox_ctl:setPosition(312, 168),
        GroupBox_ctl:setSize(84, 22),
        yes_ctl := radioButton::new(GroupBox_ctl),
        yes_ctl:setText("есть"),
        yes_ctl:setPosition(3, -2),
        yes_ctl:setWidth(28),
        no_ctl := radioButton::new(GroupBox_ctl),
        no_ctl:setText("нет"),
        no_ctl:setPosition(51, -2),
        no_ctl:setWidth(28),
        den_ctl := listButton::new(This),
        den_ctl:setPosition(108, 74),
        den_ctl:setWidth(24),
        den_ctl:setMaxDropDownRows(5),
        den_ctl:setSort(false),
        mes_ctl := listButton::new(This),
        mes_ctl:setPosition(132, 74),
        mes_ctl:setWidth(36),
        mes_ctl:setMaxDropDownRows(5),
        mes_ctl:setSort(false),
        dr2_ctl := editControl::new(This),
        dr2_ctl:setText(""),
        dr2_ctl:setPosition(576, 172),
        dr2_ctl:setWidth(24),
        den2_ctl := listButton::new(This),
        den2_ctl:setPosition(516, 172),
        den2_ctl:setWidth(24),
        den2_ctl:setMaxDropDownRows(5),
        den2_ctl:setSort(false),
        mes2_ctl := listButton::new(This),
        mes2_ctl:setPosition(540, 172),
        mes2_ctl:setWidth(36),
        mes2_ctl:setMaxDropDownRows(5),
        mes2_ctl:setSort(false),
        edit_ctl := button::new(This),
        edit_ctl:setText("Редактировать заявку"),
        edit_ctl:setPosition(192, 196),
        edit_ctl:setSize(110, 16),
        edit_ctl:setClickResponder(onРассмотретьЗаявкуClick),
        fio1_ctl := listButton::new(This),
        fio1_ctl:setPosition(108, 47),
        fio1_ctl:setWidth(84),
        fio1_ctl:setMaxDropDownRows(5),
        fio1_ctl:setVScroll(false),
        fio1_ctl:setSort(false),
        fio1_ctl:addSelectionChangedListener(onFio1SelectionChanged),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Анкета-заявление на предоставление кредита физическому лицу"),
        StaticText_ctl:setPosition(190, 6),
        StaticText_ctl:setSize(232, 16),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Ф. И. О."),
        StaticText1_ctl:setPosition(12, 46),
        StaticText1_ctl:setSize(84, 12),
        ФИО_ctl = textControl::new(This),
        ФИО_ctl:setText("Дата рождения"),
        ФИО_ctl:setPosition(12, 74),
        ФИО_ctl:setSize(84, 12),
        ФИО1_ctl = textControl::new(This),
        ФИО1_ctl:setText("Место рождения"),
        ФИО1_ctl:setPosition(12, 88),
        ФИО1_ctl:setSize(84, 12),
        ФИО2_ctl = textControl::new(This),
        ФИО2_ctl:setText("Серия и номер паспорта"),
        ФИО2_ctl:setPosition(12, 102),
        ФИО2_ctl:setSize(84, 12),
        ФИО3_ctl = textControl::new(This),
        ФИО3_ctl:setText("Адрес регистрации"),
        ФИО3_ctl:setPosition(12, 116),
        ФИО3_ctl:setSize(84, 12),
        ФИО4_ctl = textControl::new(This),
        ФИО4_ctl:setText("Адрес проживания"),
        ФИО4_ctl:setPosition(12, 130),
        ФИО4_ctl:setSize(84, 12),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Общие сведения о клиенте и условия кредитования"),
        StaticText2_ctl:setPosition(12, 26),
        StaticText2_ctl:setSize(188, 14),
        ДатаРождения_ctl = textControl::new(This),
        ДатаРождения_ctl:setText("На срок (мес)"),
        ДатаРождения_ctl:setPosition(12, 172),
        ДатаРождения_ctl:setSize(84, 12),
        ФИО5_ctl = textControl::new(This),
        ФИО5_ctl:setText("Кредит на сумму (руб)"),
        ФИО5_ctl:setPosition(12, 158),
        ФИО5_ctl:setSize(84, 12),
        StaticText4_ctl = textControl::new(This),
        StaticText4_ctl:setText("Дополнительные сведения"),
        StaticText4_ctl:setPosition(268, 26),
        StaticText4_ctl:setSize(96, 14),
        КредитВСумме_ctl = textControl::new(This),
        КредитВСумме_ctl:setText("Место работы *"),
        КредитВСумме_ctl:setPosition(216, 60),
        КредитВСумме_ctl:setSize(84, 12),
        НаСрокВМесяцах_ctl = textControl::new(This),
        НаСрокВМесяцах_ctl:setText("Должность"),
        НаСрокВМесяцах_ctl:setPosition(216, 88),
        НаСрокВМесяцах_ctl:setSize(84, 12),
        АдресПроживания_ctl = textControl::new(This),
        АдресПроживания_ctl:setText("Жильё **"),
        АдресПроживания_ctl:setPosition(420, 46),
        АдресПроживания_ctl:setSize(83, 12),
        КредитВСумме1_ctl = textControl::new(This),
        КредитВСумме1_ctl:setText("Цель кредита"),
        КредитВСумме1_ctl:setPosition(12, 144),
        КредитВСумме1_ctl:setSize(84, 12),
        МестоРаботы_ctl = textControl::new(This),
        МестоРаботы_ctl:setText("Общий трудовой стаж "),
        МестоРаботы_ctl:setPosition(216, 116),
        МестоРаботы_ctl:setSize(84, 12),
        Должность_ctl = textControl::new(This),
        Должность_ctl:setText("На текущем месте (мес)"),
        Должность_ctl:setPosition(216, 130),
        Должность_ctl:setSize(88, 12),
        ЖильёПоМестуПроживания_ctl = textControl::new(This),
        ЖильёПоМестуПроживания_ctl:setText("Тип должности"),
        ЖильёПоМестуПроживания_ctl:setPosition(216, 102),
        ЖильёПоМестуПроживания_ctl:setSize(84, 12),
        ЖильёПоМестуПроживания1_ctl = textControl::new(This),
        ЖильёПоМестуПроживания1_ctl:setText("Семейное положение"),
        ЖильёПоМестуПроживания1_ctl:setPosition(216, 144),
        ЖильёПоМестуПроживания1_ctl:setSize(84, 12),
        НаТекущемМесте_ctl = textControl::new(This),
        НаТекущемМесте_ctl:setText("Количество иждивенцев"),
        НаТекущемМесте_ctl:setPosition(216, 158),
        НаТекущемМесте_ctl:setSize(84, 12),
        НаТекущемМесте2_ctl = textControl::new(This),
        НаТекущемМесте2_ctl:setText("Доход семьи"),
        НаТекущемМесте2_ctl:setPosition(420, 74),
        НаТекущемМесте2_ctl:setSize(84, 12),
        НаТекущемМесте3_ctl = textControl::new(This),
        НаТекущемМесте3_ctl:setText("Ежемесячные расходы"),
        НаТекущемМесте3_ctl:setPosition(420, 116),
        НаТекущемМесте3_ctl:setSize(84, 12),
        ЕжемесячныеРасходы_ctl = textControl::new(This),
        ЕжемесячныеРасходы_ctl:setText("Другие кредиты"),
        ЕжемесячныеРасходы_ctl:setPosition(216, 172),
        ЕжемесячныеРасходы_ctl:setSize(84, 12),
        ДоходСемьи_ctl = textControl::new(This),
        ДоходСемьи_ctl:setText("Дополнительный доход"),
        ДоходСемьи_ctl:setPosition(420, 88),
        ДоходСемьи_ctl:setSize(84, 12),
        СемейноеПоложение_ctl = textControl::new(This),
        СемейноеПоложение_ctl:setText("Описание доп. дохода"),
        СемейноеПоложение_ctl:setPosition(420, 102),
        СемейноеПоложение_ctl:setSize(84, 12),
        ДругиеКредиты_ctl = textControl::new(This),
        ДругиеКредиты_ctl:setText("Недвижимое имущество"),
        ДругиеКредиты_ctl:setPosition(420, 130),
        ДругиеКредиты_ctl:setSize(84, 12),
        ДругиеКредиты1_ctl = textControl::new(This),
        ДругиеКредиты1_ctl:setText("Автомобиль"),
        ДругиеКредиты1_ctl:setPosition(420, 144),
        ДругиеКредиты1_ctl:setSize(84, 12),
        ТипДолжности_ctl = textControl::new(This),
        ТипДолжности_ctl:setText("Тип занятости"),
        ТипДолжности_ctl:setPosition(216, 46),
        ТипДолжности_ctl:setSize(84, 12),
        ТипДолжности1_ctl = textControl::new(This),
        ТипДолжности1_ctl:setText("Род деятельности"),
        ТипДолжности1_ctl:setPosition(216, 74),
        ТипДолжности1_ctl:setSize(84, 12),
        НаТекущемМесте1_ctl = textControl::new(This),
        НаТекущемМесте1_ctl:setText("Доход Клиента"),
        НаТекущемМесте1_ctl:setPosition(420, 60),
        НаТекущемМесте1_ctl:setSize(84, 12),
        ОписаниеДопДохода_ctl = textControl::new(This),
        ОписаниеДопДохода_ctl:setText("Доп. документ"),
        ОписаниеДопДохода_ctl:setPosition(420, 158),
        ОписаниеДопДохода_ctl:setSize(84, 12),
        ДругиеКредиты2_ctl = textControl::new(This),
        ДругиеКредиты2_ctl:setText("Пол"),
        ДругиеКредиты2_ctl:setPosition(12, 60),
        ДругиеКредиты2_ctl:setSize(84, 12),
        ДатаРождения1_ctl = textControl::new(This),
        ДатаРождения1_ctl:setText("Дата "),
        ДатаРождения1_ctl:setPosition(420, 172),
        ДатаРождения1_ctl:setSize(84, 12),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("*   - официальное название организации\n** - жильё по месту фактического проживания"),
        StaticText3_ctl:setPosition(432, 196),
        StaticText3_ctl:setSize(172, 18).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
        % end of automatic code
end implement formNewClientFiz
