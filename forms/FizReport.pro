/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement fizReport
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "forms/fizReport".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    new(Parent):-
        new(),
        setContainer(Parent).

clauses
    new():-
        userControlSupport::new(),
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
    
clauses
   print () :-
     listbox_ctl : clearAll(),
     person (Name,_,_,_,_,_,_,_,_,_,_,_,Goal,Summa,Srok,Den2,Mes2,God2),
     STROKA1 = string :: concat (Name, " - ", Goal, " - ", tostring (Summa), " рублей - "),
     STROKA2 = string :: concat (STROKA1, tostring (Srok), " месяцев - ", tostring (Den2), " ", Mes2),
     STROKA3 = string :: concat (STROKA2, " ", tostring (God2), " года"),
     listbox_ctl : add (STROKA3),
     fail.
     print () :- !.

predicates
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-   
      reconsult ("fizdb.txt"), print.

% This code is maintained automatically, do not update it manually. 13:08:13-27.4.2010
facts
    listbox_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("Физические лица"),
        This:setSize(380, 190),
        addShowListener(onShow),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(0, 0),
        listbox_ctl:setSize(374, 152),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Формат вывода информации: Ф. И. О. - цель - сумма - срок - дата заключения договора"),
        StaticText_ctl:setPosition(32, 156),
        StaticText_ctl:setSize(312, 12).
% end of automatic code
end implement fizReport
