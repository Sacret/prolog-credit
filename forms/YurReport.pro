/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement yurReport
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "forms/yurReport".
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
    
clauses
   print () :-
     listbox_ctl : clearAll(),
     predpr (Name,_,_,_,_,Goal,Summa,Srok,Vidkr,Den1,Mes1,God1),
     STROKA1 = string :: concat (Name, " - ", Goal, " - ", tostring (Summa), " рублей - "),
     STROKA2 = string :: concat (STROKA1, tostring (Srok), " месяцев - ", Vidkr, " - ", tostring (Den1)),
     STROKA3 = string :: concat (STROKA2, " ", Mes1, " ", tostring (God1), " года"),
     listbox_ctl : add (STROKA3),
     fail.
     print () :- !.


predicates
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-
      reconsult ("yurdb.txt"), print.

% This code is maintained automatically, do not update it manually. 13:11:12-27.4.2010
facts
    listbox_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("Юридические лица"),
        This:setSize(380, 186),
        addShowListener(onShow),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(0, 0),
        listbox_ctl:setSize(374, 152),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Формат вывода информации: Название - цель - сумма - срок - вид кредита - дата заключения договора"),
        StaticText_ctl:setPosition(8, 156),
        StaticText_ctl:setSize(372, 12).
% end of automatic code
end implement yurReport
