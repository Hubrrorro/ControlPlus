   M S B A M L   `   `   `  ����I  EAppControlCMMI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullY1clr-namespace:AppControlCMMI.Formas.Configuracion#AppControlCMMI.Formas.Configuracion  5   	   3    -AppControlCMMI.Formas.Configuracion.SVNTicket   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   Clocal1clr-namespace:AppControlCMMI.Formas.Configuracion     5   	     � Title$  	SVNTicket��5   	   $	��400��6   $	��740��6(   .��5	      � .+�5
   
   � -   5         �Name$ BusquedaGrid��5
      .+�5      �� -   5         ��Name$ groupBox��5      $��Buscar Ticket��6)   $
��Left=�6@   $��	10,10,0,0q�6[   $	��Top=�6n   $	��112��6�   $	��712��6�   .��5      � .+�5      �� -   5         ��Name$ 	txtnombre��5      $
��Left=�61   $��23��6L   $��
241,36,0,0q�6X    �� TextWrapping$
 Wrap=�6l   $�� ��6�   $	��Top=�6�   $	��214��6�   �� 5      -   5        $ 	txtticket��5      $
��Left=�61   $��23��6L   $��8,36,0,0q�6X   $
 Wrap=�6j   $�� ��6~   $	��Top=�6�   $	��212��6�   �� 5      -   5         ��Name$ 
ddlSistema��5      $
��Left=�63   $��
472,36,0,0q�6N   $	��Top=�6b   $	��214��6z   �� 5      -   5         ��Name$ 	btnbuscar��5      $
��Left=�61   $��
604,70,0,1q�6L   $��77��6`   $��Buscar��6k   6|   5      5      &   System.Windows.Controls.DataGrid  5      -   5          Name$ dgTicket��5      $
��Left=�6)   $��
14,131,0,0q�6D   $	��Top=�6X   $	��191��6p   $	��708��6}    � 	Resources 5      )  #System.Windows.Controls.DataGridRow	 �� 
TargetType��%E   '        �� 5      "	  6   .�5      -   5        5      5      5      5      � 5   
   -	   5        $ 
AsignaGrid��5      $y�Hidden=�6$   .+�5      �� -
   5        $ 	groupBox1��5      $��Ingresa tu direccion��6*   $
��Left=�6H   $��	10,10,0,0q�6c   $	��Top=�6v   $	��306��6�   $	��712��6�   .��5      � .+�5      �� -   5        
 ��Name$
 	lblticket��5      $��Label��6/   $
��Left=�6?   $��
119,10,0,0q�6Z   $	��Top=�6n   $	��144��6�   �� 5       -   5        $
 	lblnombre��5       $��Label��6/   $
��Left=�6?   $��
119,41,0,0q�6Z   $	��Top=�6n   $	��144��6�   �� 5!      -   5        $
 
lblsistema��5!      $��Label��60   $
��Left=�6@   $��
119,72,0,0q�6[   $	��Top=�6o   $	��144��6�   �� 5"      -   5        $ txtdireccion��5"      $
��Left=�64   $��23��6O   $��119,114,0,0q�6[   $
 Wrap=�6p   $�� ��6�   $	��Top=�6�   $	��302��6�   �� 5#      -   5        $
 lblid��5#      $�� ��6+   $
��Left=�66   $��
119,10,0,0q�6Q   $	��Top=�6e   $	��144��6}   $y�Hidden=�6�   �� 5$      -   5        $��Agrega Direccion��5$      $
��Left=�68   $��558,227,0,0q�6S   $	��Top=�6h   $	��132��6�   $��47��6�   6�   �� 5%      -   5        $
 lblrutaLocal��5%      $�� ��62   $
��Left=�6=   $��119,155,0,0q�6X   $	��Top=�6m   $	��571��6�   �� 5&      -   5        $��Buscar��5&      $
��Left=�6.   $��119,186,0,0q�6I   $	��Top=�6^   $��61��6v   $��28��6�   6�   5'      5(      5*      5+      5,      