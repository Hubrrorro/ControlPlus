   M S B A M L   `   `   `  ����I  EAppControlCMMI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullK*clr-namespace:AppControlCMMI.Formas.InicioAppControlCMMI.Formas.Inicio  5   	   1    +AppControlCMMI.Formas.Inicio.FrmPlanProceso   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   <local*clr-namespace:AppControlCMMI.Formas.Inicio     5   	   -   5          � Title$  FrmPlanProceso��5   	   $	��400��6!   $	��740��6.   .��5	      � .+�5
   
   � -   5         �Name$ BusquedaGrid��5
      .+�5      �� -   5         ��Name$ groupBox��5      $��Buscar Ticket��6)   $
��Left=�6@   $��	10,10,0,0q�6[   $	��Top=�6n   $	��112��6�   $	��712��6�   .��5      � .+�5      �� -   5         ��Name$ 	txtnombre��5      $
��Left=�61   $��23��6L   $��
241,36,0,0q�6X    �� TextWrapping$
 Wrap=�6l   $�� ��6�   $	��Top=�6�   $	��214��6�   �� 5      -   5        $ 	txtticket��5      $
��Left=�61   $��23��6L   $��8,36,0,0q�6X   $
 Wrap=�6j   $�� ��6~   $	��Top=�6�   $	��212��6�   �� 5      -   5         ��Name$ 
ddlSistema��5      $
��Left=�63   $��
472,36,0,0q�6N   $	��Top=�6b   $	��214��6z   �� 5      -   5         ��Name$ 	btnbuscar��5      $
��Left=�61   $��
604,70,0,1q�6L   $��77��6`   $��Buscar��6k   6|   5      5      &   System.Windows.Controls.DataGrid  5      -   5          Name$ dgTicket��5      $
��Left=�6)   $��
14,131,0,0q�6E   $	��Top=�6Y   $	��191��6q   $
��Auto��6~    � 	Resources 5      )  #System.Windows.Controls.DataGridRow	 �� 
TargetType��%E   '        �� 5      "	  6   .�5      -	   5        5      5      5      5      � 5   
   -
   5        $ 
AsignaGrid��5      $y�Hidden=�6#   .+�5      �� -   5        $��	lblTicket��5      $y�Hidden=�6%   6;   �� 5      -   5        $ 
cbTemplate��5      $
��Left=�6+   $��	98,26,0,0q�6F   $	��Top=�6Y   $	��296��6q     5      -   5        $ dataGrid��5      $
��Left=�6)   
   AutoGenerateColumns
 .  $��	10,76,0,0q�6`   $	��Top=�6s   $	��714��6�   $	��241��6�      Columns 5       0  *System.Windows.Controls.DataGridTextColumn  5!      ,  &System.Windows.Controls.DataGridColumn   
Visibility$ Hidden=�6D   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6)   �� *idGuia+6Z     5"         Header$ Proceso��6)    6:   �� *	proceso+6X     5#      $ 	Actividad��6)    6<   �� *	actividad+6\     5$      $ Producto de trabajo��6)    6F   �� *
producto+6e     5%      $
 Fase��6)    67   �� *fase+6R   4  .System.Windows.Controls.DataGridComboBoxColumn  5&      $ Tipo Ajuste��6-      SelectedItemBinding 6B   �� *ajuste+   ItemsSource 6j   �� *Ajuste+5'        5(      $ Documento de Reemplazo��6-    6M   �� *nombre+ 6u   �� *	Listado+5)        5*      $ Justificacion��6)   6B   5,      5.      50      51      