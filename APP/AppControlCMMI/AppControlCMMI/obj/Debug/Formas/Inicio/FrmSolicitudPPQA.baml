   M S B A M L   `   `   `  ����I  EAppControlCMMI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullK*clr-namespace:AppControlCMMI.Formas.InicioAppControlCMMI.Formas.Inicio  5   	   3    -AppControlCMMI.Formas.Inicio.FrmSolicitudPPQA   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   <local*clr-namespace:AppControlCMMI.Formas.Inicio     5   	     � Title$  FrmSolicitudPPQA��5   	   $	��400��6#   $	��740��60   .��5	      � .+�5
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
   -	   5        $ Envio��5      $y�Hidden=�6   .+�5      �� -
   5        $ 	groupBox1��5      $��Solicitud PPQA��6*   $
��Left=�6B   $��
126,50,0,0q�6]   $	��Top=�6q   $	��228��6�   $	��507��6�   .��5      � .+�5      �� -   5        
 ��Name$
 	lblticket��5      $y�Hidden=�6/   �� 5       $��WrapWithOverflow=�6    $��0,36,-2.6,90.4q�6@   ��Genera el archivo de solicitud de PPQA y se envia por correo electrónico a la persona encargada de esta gestión asi como al líder de proyecto5"      �� 5#      -   5        $ btnEnvio��5#      $��Enviar Solicitud��6/   $
��Left=�6J   $��321,136,0,0q�6e   $	��Top=�6z   $	��113��6�   $��27��6�   6�   5%      5&      5(      5)      5*      