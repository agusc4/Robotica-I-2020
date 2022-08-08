
clc;clear;

dh = [0 0.520 .160 pi/2 0;
    0 0 0.980 0 0;
    0 0 0 pi/2 0;
    0 0.8545 0 -pi/2 0;
    0 0 0 pi/2 0;
    0 0.1605 0 0 0];

R=SerialLink(dh,'name','kuka KR8');

R.qlim(1,1:2) = [-185,  185]*pi/180;
R.qlim(2,1:2) = [-155,  95]*pi/180;
R.qlim(3,1:2) = [-85, 228]*pi/180;
R.qlim(4,1:2) = [-165,  165]*pi/180;
R.qlim(5,1:2) = [-140,  115]*pi/180;
R.qlim(6,1:2) = [-350,  350]*pi/180;

R.offset = [0 pi/2 0 pi/2 0 0];

R.tool = transl(0, 0, 0.4);
Tool = R.tool.double;

R.base = transl(0, 0, 0.5);
Base = R.base.double;

q_ini=[0 0 0 0 0 0];

P = [1.9 -0.3 0.65;
     1.9 .3 0.65;
     1.3 -0.3 0.65;
     1.3 .3 0.65;
     1.9 -0.3 1.25;
     1.9 .3 1.25;
     1.3 -0.3 1.25;
     1.3 .3 1.25];

 P_laser = [-3.14 -0.385 0;
          -3.14 .385 0;
          -1.3 -0.385 0;
          -1.3 .385 0;
          -3.14 -0.385 1.39;
          -3.14 .385 1.39;
          -1.3 -0.385 1.39;
          -1.3 .385 1.39];
 
fprintf('Bienvenido a nuestro trabajo final de Robotica 1\n')
fprintf('Realizado sobre brazo KUKA KR 8 R2100-2 arc HW\n\n')
fprintf('Las opciones son las siguientes:\n\n')
fprintf('1: Cinematica directa \n')
fprintf('2: Cinematica inversa \n')
fprintf('3: Singularidades \n')
fprintf('4: Trayectoria \n\n')
x=input('Ingrese opcion: ');

switch x
    case 1
        fprintf('Cinematica directa\n');
        fprintf('Nuestra funcion controla los limites articulares\n')
        fprintf('Tambien nos devuelve la matriz homogenea de ese vector\n')
        fprintf('Los limites articulares del brazo son: \n');
        R.qlim*180/pi

        fprintf('Se mostraran resultados de nuestra funcion cinematica directa \n');
        fprintf('Primero vector dentro de los limites articulares y su T homogenea\n');
        q1=[150 0 45 35 30 20]
        q1=q1*pi/180;
        T1a=c_dir(q1,dh,R);
        T1b=R.fkine(q1);
        fprintf('Nuestros resultados:\n');
        T1a
        fprintf('Comparando valores con fkine\n')
        T1b
        figure(1);
        R.plot(q1);
        hold on;
        trplot(T1a);
        fprintf('Presione una tecla para continuar\n')
        pause();
        close(figure(1));
        fprintf('Vector fuera de los limites articulares\n');
        q2=[300 45 280 350 300 200]
        q2=q2*pi/180;
        [T2a,q]=c_dir(q2,dh,R);
        fprintf('Nuevo valor de q')
        q=q*180/pi
        fprintf('Esto previene al brazo de colisiones por pasar limites articulares\n')
        figure(2);
        fprintf('Posicion articular sin aplicar verificacion de limites\n')
        R.plot(q2);
        fprintf('Presione una tecla para continuar\n')
        pause();
        fprintf('Posicion articular con verificacion de limites\n')
        R.plot(q)
        fprintf('###Fin###')
    case 2
        fprintf('Mediante matrices homogeneas, se le indicara al brazo ir a una posicion \n')
        fprintf('dentro del espacio de trabajo y a una posicion fuera del espacio de trabajo.\n')
        fprintf('Se mostraran las 8 generadas por nuestra funcion.\n')
        T_dentro=transl(1.2,1.3,1.6)*trotz(-pi/2)*trotx(-pi/4)
        
        [q1,f,q_dentro]=cinv(q_ini,dh,T_dentro,R);
        fprintf('El conjunto de soluciones articulares calculadas es:\n')
        q_dentro
        fprintf('Primera solucion dentro del espacio de trabajo:\n')
        figure(1);
        R.plot(q_dentro(:,1)');
        hold on;
        trplot(T_dentro);
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Segunda solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,2)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Tercera solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,3)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Cuarta solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,4)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Quinta solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,5)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Sexta solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,6)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Septima solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,7)');
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Octava solucion dentro del espacio de trabajo:\n')
        R.plot(q_dentro(:,8)');
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
        fprintf('Segunda solucion fuera del espacio de trabajo:\n')
        fprintf('Nuestra funcion devuelve la posicion mas cercana\n')
        close(figure(1));
        T_fuera=transl(1.2,1.3,3)
        [q1,f,q_fuera]=cinv(q_ini,dh,T_fuera,R);
        fprintf('El conjunto de soluciones articulares calculadas es:\n')
        q_fuera
        fprintf('Primera solucion fuera del espacio de trabajo:\n')
        figure(2)
        R.plot(q_fuera(:,1)')
        hold on;
        trplot(T_fuera);
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Segunda solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,2)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Tercera solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,3)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Cuarta solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,4)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Quinta solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,5)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Sexta solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,6)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Septima solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,7)')
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
         fprintf('Octava solucion fuera del espacio de trabajo:\n')
        R.plot(q_fuera(:,8)')
        fprintf('###Fin###')
    case 3
        fprintf('Se pide hallar el jacobiano y determinante del robot\n')
        fprintf('Al ser de 6 GDL, el calculo de los mismos resulta muy complejo y dificil de manejar \n')
        fprintf('A fines prácticos se hallarán singularidades mediante aproximación numérica\n')
        fprintf('La siguiente función calcula el determinante numérico para 10000 posiciones aleatorias\n')
        fprintf('Precione una tecla para continuar (tiene que esperar 10 000 interaciones) \n')
        pause();
        
        [path, Pos] = jacob(R);
        
        fprintf('Posicion singular 1\n')
        figure(1);
        R.plot(path(:,1)','workspace',[-3.5 3.5 -3.5 3.5 -3 3]);        
        
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Posicion singular 2:\n')
        close(figure(1));
        figure(2)
        R.plot(path(:,2)','workspace',[-3.5 3.5 -3.5 3.5 -3 3]);        
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Posicion singular 3:\n')
        close(figure(2));
        figure(3)
        R.plot(path(:,3)','workspace',[-3.5 3.5 -3.5 3.5 -3 3]);        
        fprintf('Presione una tecla para continuar\n')
        pause();       
        fprintf('Posicion singular 4:\n')
        close(figure(3));
        figure(4)
        R.plot(path(:,4)','workspace',[-3.5 3.5 -3.5 3.5 -3 3]);        
        fprintf('Presione una tecla para continuar\n\n');
        pause(); 
        close(figure(4));
        
        %5 posiciones de trabajo para analizar el jacobiano
        fprintf('Ahora se analizarán 5 posiciones típicas de trabajo para el robot \n')
        P1=transl([1.3 0 .75]);
        P1=P1*trotx(-pi/2)*troty(pi/2);

        P2=transl([1.8 0.3 .75]);
        P2=P2*trotz(pi)*trotx(3*pi/2);

        P3=transl(P(3,1),P(3,2),P(3,3));
        P3=P3*trotx(-pi/2)*troty(pi/2);
        
        P4=transl(P(4,1),P(4,2),P(4,3));
        P4=P4*trotx(-pi/2)*troty(pi/2);

        P5=transl(1.6,-.3, 1);
        P5=P5*trotz(pi/2)*trotx(pi/2)*troty(pi/2);
        
        i1=cinv([0 0 0 0 0 0],dh,P1,R);
        i2=cinv([0 0 0 0 0 0],dh,P2,R);
        i3=cinv([0 0 0 0 0 0],dh,P3,R);
        i4=cinv([0 0 0 0 0 0],dh,P4,R);
        i5=cinv([0 0 0 0 0 0],dh,P5,R);

        J1=R.jacob0(i1);
        J2=R.jacob0(i2);
        J3=R.jacob0(i3);
        J4=R.jacob0(i4);
        J5=R.jacob0(i5);
        
        J1=J1(1:3,:);
        J2=J2(1:3,:);
        J3=J3(1:3,:);
        J4=J4(1:3,:);
        J5=J5(1:3,:);
        
        fprintf('Primer elipsoide\n')
        figure(1);
        R.plot(i1,'workspace',[-3 3 -3 3 -1 3]);
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        plot_ellipse(J1*J1',transl(P1));
        hold off
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Segundo elipsoide:\n')
        close(figure(1));
        figure(2)
        R.plot(i2,'workspace',[-3 3 -3 3 -1 3]);
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        plot_ellipse(J2*J2',transl(P2));
        hold off
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Tercer elipsoide:\n')
        close(figure(2));
        figure(3)

        R.plot(i3,'workspace',[-3 3 -3 3 -1 3]);
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        plot_ellipse(J3*J3',transl(P3));
        hold off
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Cuarto elipsoide:\n')
       close(figure(3));
       figure(4)
       R.plot(i4,'workspace',[-3 3 -3 3 -1 3]);
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        plot_ellipse(J4*J4',transl(P4));
        hold off
        fprintf('Presione una tecla para continuar\n\n');
        pause();       
        fprintf('Quinto elipsoide:\n')
        close(figure(4));
        figure(5)
        R.plot(i5,'workspace',[-3 3 -3 3 -1 3]);
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        plot_ellipse(J5*J5',transl(P5));
        fprintf('###Fin###')
        
    case 4
        fprintf('Calculo de trayectoria para nuestra tarea de limpieza\n mediante el uso de jtraj y ctraj\n\n')
        fprintf('Primero se mostraran resultados con jtraj\n');
    
        %vertice inferior derecho del cubo
        T1f=transl(P(3,:)');
        T1f=T1f*trotx(-pi/2)*troty(pi/2);

        Tld=transl(P(3,:)');
        Td=Tld*trotx(-pi/2)*trotz(-pi/2);

        Ts=transl(P(7,:)');
        Ts=Ts*trotx(pi)*trotz(-pi/2);

        Ti=transl(P(8,:)');
        Ti=Ti*trotx(pi/2)*trotz(pi/2);


        %Se definen 40 puntos de la trayectoria de la tarea
        %Matriz de posicion inicial
        T0 = c_dir(q_ini,dh,R);
        
        %Maniobra de seguridad para iniciar la tarea.
        T01=T0*transl(0,0,-0.4);
        T02=T01*transl(0,.7,0);
        
        %Cara frontal comenzando en vertice inferior derecho
        T1=T1f*transl(0,-0.05,0);%Subimos esa posicion 5cm
        T2=T1*transl(-0.6,0,0); %recorrer de derecha a izquierda en direccion Y
        T3=T2*transl(0,-0.1,0  ); %subir 10cm
        T4=T3*transl(0.6,0,0); %recorrer de izqquierda a derecha en direccion Y
        T5=T4*transl(0,-0.1,0); %subir 10cm
        T6=T5*transl(-0.6,0,0); %derecha a izquierda 
        T7=T6*transl(0,-0.1,0); %subir
        T8=T7*transl(0.6,0,0); %izquierda a derecha
        T9=T8*transl(0,-0.1,0); %subir
        T10=T9*transl(-0.6,0,0); %derecha a izquierda
        T11=T10*transl(0,-0.1,0); %subir
        T12=T11*transl(0.6,0,0); %izquierda a derecha

        T13=T12*transl(0.3,0,0); %maniobra de seguridad

        %Cara derecha
        T14=Td*transl(0,0.05,0);
        T15=T14*transl(0.6,0,0);
        T16=T15*transl(0,0.1,0);
        T17=T16*transl(-0.6,0,0);
        T18=T17*transl(0,0.1,0);
        T19=T18*transl(0.6,0,0);

        T20=T19*transl(0.3,0,0)*trotz(pi); %Maniobra de seguridad
        %Cara superior
        T21=Ts*transl(0,0.05,0);
        T22=T21*transl(0.6,0,0);
        T23=T22*transl(0,0.1,0);
        T24=T23*transl(-0.6,0,0);
        T25=T24*transl(0,0.1,0);
        T26=T25*transl(0.6,0,0);

        T27=T26*transl(0.3,0,0);%Maniobra de seguridad

        %Cara izquierda
        T28=Ti*transl(0,-0.05,0);
        T29=T28*transl(-0.6,0,0);
        T30=T29*transl(0,-0.1,0);
        T31=T30*transl(0.6,0,0);
        T32=T31*transl(0,-0.1,0);
        T33=T32*transl(-0.6,0,0);

        %Maniobra de seguridad para volver a home
        T34=T33*transl(0,0,-0.2);
        T35=T34*transl(.8,0,0);
        T36=T35*trotx(pi/2);
                 
        TT=[T0 T01 T02 T1 T2 T3 T4 T5 T6 T7 T8 T9 T10 T11 T12 T13 T14 T15 T16 T17 T18 T19 T20 T21 T22 T23 T24 T25 T26 T27 T28 T29 T30 T31 T32 T33 T34 T35 T36 T0];
        
        fprintf('La trayectoria obtenida con jtraj es satisfactoria para la tarea\n');
        fprintf('Presione una tecla para continuar\n');
        pause();
        
        c=1;
        qq=[0;0;0;0;0;0];
        

        %Se calcula la inversa para cada matriz que define un punto de la
        %trayectoria
        for i=1:length(TT)/4-1
        aux=cinv(qq(:,i)',dh,TT(:,c+4*i:c+4*i+3),R);
        qq=[qq aux'];
        end
        QJ=[];
        QJv = [];
        QJa = [];

        %uso de Jtraj
        for i=1:length(TT)/4-1
        [QQ, QQv, QQa]=jtraj(qq(:,i)',qq(:,i+1)',100);
        QJ=[QJ;QQ];
        QJv=[QJv;QQv];
        QJa=[QJa;QQa];
        end
        figure(1)
        R.plot([0 0 0 0 0 0],'scale',.6,'trail', {'r'});
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        R.plot(QJ,'delay',0.01)
        
        fprintf('Ahora se mostrara trayectoria obtenida con ctraj\n');
        fprintf('Presione una tecla para continuar\n');
        pause();
        %%
        c=1;
        f=4;
        QQC=[];
        %Se calcula la interpolacion entre matrices dando como resultado un arreglo
        %de 4x4x3700
        for i=1:length(TT)/4-1
        QQC(:,:,i*100-99:i*100)=ctraj(TT(:,c:f),TT(:,c+4:f+4),100);
        c=c+4;
        f=f+4;
        end
        %%
        QC=q_ini;
        %Se calcula la inversa para las 3700 matrices que describen el camino

        for i=2:length(TT)*25-100
        Taux=QQC(:,:,i);
        q_obj=cinv(QC(i-1,:),dh,QQC(:,:,i),R);
        QC=[QC;q_obj];    
        end

        %%
        close(figure(1))
        figure(2);
        R.plot(q_ini,'scale',0.6,'trail', {'r'});
        hold on;
        cubo(P,'green');
        cubo(P_laser,'red');
        R.plot(QC,'delay',0.01,'trail', {'r'});
        %%
       
        fprintf('A continuacion se mostraran graficas de posicion, velocidad y aceleracion\n\n')
        fprintf('Para la trayectoria realizada con Jtra y Ctraj\n\n')
        fprintf('Presione una tecla para continuar\n');
        pause();
        close all;
        %Velocidad. cantidad de puntos dividido tiempo de la tarea
        QQ3V=diff(QC)*3900/20;

        %Aceleracion
        QQ3A=diff(QQ3V)*3900/20;

        %Para ctraj
        figure(1)
        subplot(3,1,1)
        qplot(QC);
        title('Posiciones articulares (ctraj)');
        subplot(3,1,2)
        qplot(QQ3V);
        title('Velocidades articulares (ctraj)');
        subplot(3,1,3)
        qplot(QQ3A);
        title('Aceleraciones articulares (ctraj)');

        %Para jtraj
        figure(2)
        subplot(3,1,1)
        qplot(QJ)
        title('Posiciones articulares (jtraj)');
        subplot(3,1,2)
        qplot(QJv)
        title('Velocidades articulares (jtraj)');
        subplot(3,1,3)
        qplot(QJa)
        title('Aceleraciones articulares (jtraj)');
        fprintf('###Fin###')
        
end





