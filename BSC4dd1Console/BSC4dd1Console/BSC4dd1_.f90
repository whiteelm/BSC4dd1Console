    program bsc4dd1
!   BSCL (Broad-Side Coupled Line)- Связанные линии с лицевой связью 
    implicit real*8(a-b,d-h,o-v,x-y)
    dimension dL(2, 2),dC(2, 2), aa(9), dCC(2, 2), dLL(2, 2), dZ0(2, 2), Um(2, 2), em(2)
    n=2; aw1 =0.4; aw2= 0.8; h1=0.2;  h2=0.25 ; t=.015; e1=12; e2=1; e3=1
    ip = -2	   ! Индекс печати = -2,-1,0,1. Если ip=0, то всё печатаем.
    aa(1) = 2 ! количество линий
    aa(2) = aw1 ! ширина верхней линии 
    aa(3) = aw2 ! ширина нижней линии
    aa(4) = h1 ! высота верхнего слоя (не зависит от t, отличается от AWR!)
    aa(5) = h2 ! высота нижнего слоя
    aa(6) = t ! толщина полосок (линий); нижняя полоска уходит вглубь верхнего слоя h1 
    aa(7) = e1 ! диэл.проницаем. верхнего слоя
    aa(8) = e2 ! диэл.проницаем. нижней подложки
    aa(9) = e3 ! диэл.проницаем. среды
    call main(ip,aa,dL,dC)
    print*,'Capacitance matrix [C] (pF/m)';		call DPRINT(dC, n)
    print*,'Inductance matrix [L] (uH/m)';		call DPRINT(dL, n)
    dCC=dC 
    dLL=dL
    call dminv(dLL,n,ad)
    call nroot(n,dCC,11.127*dLL,em,Um)
    print*,'Modal voltage matrix [Um] (V)'; 	call DPRINT(Um, n)
    print*,'Modal dielectric permitivities [em]';
    do i =1,n;
        print '(f8.2)',em(i);
    enddo;
    if(n==2) print'(a20,f8.4)','m = sqrt(em1/em2) =', sqrt(em(1)/em(2));  print*
    call impedance(n,dC,Um,em,dZ0)
    print*,'Impedance matrix [Z0] (Ohm)'; 	    call DPRINT(dZ0, n)
    
    end