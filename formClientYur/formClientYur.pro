/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formClientYur
    inherits formWindow
    open core, vpiDomains

constants
    className = "formClientYur/formClientYur".
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

% запись данных на форму
predicates
    print : ().
    info : (string Stroka).
    
clauses
   print () :-
     clients_ctl : clearAll(),
     predpr (Name,_,_,_,_,_,_,_,_,_,_,_),
     clients_ctl : add (Name),
     fail.
     print () :- !.

clauses
  info (Name) :-
    predpr (Name, Adr, Chet, Deyat, Ufio,  _, _, _, _, _, _, _),
    nazv_ctl : setText (Name),
    adr_ctl : setText (Adr),
    chet_ctl : setText (Chet),
    deyat_ctl : setText (Deyat),
    ufio_ctl : setText (Ufio),   
    fail.
    info (Name) :- nazv_ctl : setText (Name), !.   

% при показе формы    
predicates
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-
      reconsult ("yurdb.txt"), print.

% выбор из выпадающего списка
predicates
    onClientsSelectionChanged : listControl::selectionChangedListener.
clauses
    onClientsSelectionChanged(_Source) :-
      Name = clients_ctl : getText(),
      info (Name).

% This code is maintained automatically, do not update it manually. 14:52:07-26.4.2010
facts
    clients_ctl : listButton.
    nazv_ctl : editControl.
    adr_ctl : editControl.
    chet_ctl : editControl.
    deyat_ctl : editControl.
    ufio_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Клиенты - юридические лица~"),
        setRect(rct(50,40,290,168)),
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
        nazv_ctl := editControl::new(This),
        nazv_ctl:setText(""),
        nazv_ctl:setPosition(124, 48),
        nazv_ctl:setWidth(84),
        adr_ctl := editControl::new(This),
        adr_ctl:setText(""),
        adr_ctl:setPosition(124, 62),
        adr_ctl:setWidth(84),
        chet_ctl := editControl::new(This),
        chet_ctl:setText(""),
        chet_ctl:setPosition(124, 76),
        chet_ctl:setWidth(84),
        deyat_ctl := editControl::new(This),
        deyat_ctl:setText(""),
        deyat_ctl:setPosition(124, 90),
        deyat_ctl:setWidth(84),
        ufio_ctl := editControl::new(This),
        ufio_ctl:setText(""),
        ufio_ctl:setPosition(124, 104),
        ufio_ctl:setWidth(84),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Информация о клиентах - юридических лицах"),
        StaticText_ctl:setPosition(36, 8),
        StaticText_ctl:setSize(162, 12),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Название предприятия"),
        StaticText1_ctl:setPosition(28, 48),
        StaticText1_ctl:setSize(84, 12),
        ФИО_ctl = textControl::new(This),
        ФИО_ctl:setText("Юридический адрес"),
        ФИО_ctl:setPosition(28, 62),
        ФИО_ctl:setSize(84, 12),
        ФИО1_ctl = textControl::new(This),
        ФИО1_ctl:setText("Расчётный счёт"),
        ФИО1_ctl:setPosition(28, 76),
        ФИО1_ctl:setSize(84, 12),
        ФИО2_ctl = textControl::new(This),
        ФИО2_ctl:setText("Тип деятельности"),
        ФИО2_ctl:setPosition(28, 90),
        ФИО2_ctl:setSize(84, 12),
        ФИО3_ctl = textControl::new(This),
        ФИО3_ctl:setText("Учредитель (Ф. И. О.)"),
        ФИО3_ctl:setPosition(28, 104),
        ФИО3_ctl:setSize(84, 12).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement formClientYur
