/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formClientFiz
    inherits formWindow
    open core, vpiDomains

constants
    className = "formClientFiz/formClientFiz".
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
                 
% запись данных на форму
predicates
    print : ().
    info : (string Stroka).
    
clauses
   print () :-
     clients_ctl : clearAll(),
     person (Name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),
     clients_ctl : add (Name),
     fail.
     print () :- !.

clauses
  info (Name) :-
    person (Name, Pol, Den1, Mes1, God1, Mr, Pasp, Adr1, Adr2, Mrab, Dolzhn, Rdeyat, _, _, _, _, _, _),
    fio_ctl : setText (Name),
    pol_ctl : setText (Pol),
    Stroka = string :: concat (tostring(Den1), " ", Mes1, " ", tostring(God1)),
    dr_ctl : setText (Stroka),
    mr_ctl : setText (Mr),
    pasp_ctl : setText (Pasp),
    adr1_ctl : setText (Adr1),
    adr2_ctl : setText (Adr2),
    mrab_ctl : setText (Mrab),
    dolzhn_ctl : setText (Dolzhn),
    rdeyat_ctl : setText (Rdeyat),
    fail.
    info (Name) :- fio_ctl : setText (Name), !.    

% при показе формы
predicates
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-
      reconsult ("fizdb.txt"), print.

% выбор из выпадающего списка
predicates
    onClientsSelectionChanged : listControl::selectionChangedListener.
clauses
    onClientsSelectionChanged(_Source) :-
      Name = clients_ctl : getText(),
      info (Name).

% This code is maintained automatically, do not update it manually. 13:20:04-27.4.2010
facts
    clients_ctl : listButton.
    fio_ctl : editControl.
    pol_ctl : editControl.
    dr_ctl : editControl.
    mr_ctl : editControl.
    pasp_ctl : editControl.
    adr1_ctl : editControl.
    adr2_ctl : editControl.
    mrab_ctl : editControl.
    dolzhn_ctl : editControl.
    rdeyat_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Клиенты - физические лица~"),
        setRect(rct(50,40,290,240)),
        setDecoration(titlebar([closebutton(),minimizebutton()])),
        setBorder(thinBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        clients_ctl := listButton::new(This),
        clients_ctl:setPosition(28, 28),
        clients_ctl:setWidth(180),
        clients_ctl:setMaxDropDownRows(4),
        clients_ctl:addSelectionChangedListener(onClientsSelectionChanged),
        fio_ctl := editControl::new(This),
        fio_ctl:setText(""),
        fio_ctl:setPosition(124, 48),
        fio_ctl:setWidth(84),
        pol_ctl := editControl::new(This),
        pol_ctl:setText(""),
        pol_ctl:setPosition(124, 62),
        pol_ctl:setWidth(84),
        dr_ctl := editControl::new(This),
        dr_ctl:setText(""),
        dr_ctl:setPosition(124, 76),
        dr_ctl:setWidth(84),
        mr_ctl := editControl::new(This),
        mr_ctl:setText(""),
        mr_ctl:setPosition(124, 90),
        mr_ctl:setWidth(84),
        pasp_ctl := editControl::new(This),
        pasp_ctl:setText(""),
        pasp_ctl:setPosition(124, 104),
        pasp_ctl:setWidth(84),
        adr1_ctl := editControl::new(This),
        adr1_ctl:setText(""),
        adr1_ctl:setPosition(124, 118),
        adr1_ctl:setWidth(84),
        adr2_ctl := editControl::new(This),
        adr2_ctl:setText(""),
        adr2_ctl:setPosition(124, 132),
        adr2_ctl:setWidth(84),
        mrab_ctl := editControl::new(This),
        mrab_ctl:setText(""),
        mrab_ctl:setPosition(124, 146),
        mrab_ctl:setWidth(84),
        dolzhn_ctl := editControl::new(This),
        dolzhn_ctl:setText(""),
        dolzhn_ctl:setPosition(124, 160),
        dolzhn_ctl:setWidth(84),
        rdeyat_ctl := editControl::new(This),
        rdeyat_ctl:setText(""),
        rdeyat_ctl:setPosition(124, 174),
        rdeyat_ctl:setWidth(84),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Информация о клиентах - физических лицах"),
        StaticText_ctl:setPosition(40, 8),
        StaticText_ctl:setSize(156, 12),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Ф. И. О."),
        StaticText1_ctl:setPosition(28, 48),
        StaticText1_ctl:setSize(84, 12),
        ФИО_ctl = textControl::new(This),
        ФИО_ctl:setText("Пол"),
        ФИО_ctl:setPosition(28, 62),
        ФИО_ctl:setSize(84, 12),
        ФИО1_ctl = textControl::new(This),
        ФИО1_ctl:setText("Дата рождения"),
        ФИО1_ctl:setPosition(28, 76),
        ФИО1_ctl:setSize(84, 12),
        ФИО2_ctl = textControl::new(This),
        ФИО2_ctl:setText("Место рождения"),
        ФИО2_ctl:setPosition(28, 90),
        ФИО2_ctl:setSize(84, 12),
        ФИО3_ctl = textControl::new(This),
        ФИО3_ctl:setText("Серия и номер паспорта"),
        ФИО3_ctl:setPosition(28, 104),
        ФИО3_ctl:setSize(84, 12),
        ФИО4_ctl = textControl::new(This),
        ФИО4_ctl:setText("Адрес регистрации"),
        ФИО4_ctl:setPosition(28, 118),
        ФИО4_ctl:setSize(84, 12),
        ФИО5_ctl = textControl::new(This),
        ФИО5_ctl:setText("Адрес проживания"),
        ФИО5_ctl:setPosition(28, 132),
        ФИО5_ctl:setSize(84, 12),
        ФИО6_ctl = textControl::new(This),
        ФИО6_ctl:setText("Место работы"),
        ФИО6_ctl:setPosition(28, 147),
        ФИО6_ctl:setSize(84, 12),
        ФИО7_ctl = textControl::new(This),
        ФИО7_ctl:setText("Должность"),
        ФИО7_ctl:setPosition(28, 161),
        ФИО7_ctl:setSize(84, 12),
        ФИО8_ctl = textControl::new(This),
        ФИО8_ctl:setText("Род деятельности"),
        ФИО8_ctl:setPosition(28, 174),
        ФИО8_ctl:setSize(84, 12).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement formClientFiz
