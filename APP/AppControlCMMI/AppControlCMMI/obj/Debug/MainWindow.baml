   M S B A M L   `   `   `  ����I  EAppControlCMMI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null/clr-namespace:AppControlCMMIAppControlCMMI  5   	       AppControlCMMI.MainWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   .localclr-namespace:AppControlCMMI     5   	     � Title$  Login��5   	   .��5	      �  J� Effect 5
   
   3  -System.Windows.Media.Effects.DropShadowEffect  5      ��5   
   �� 5       �� EndPoint$ 0.5,1&�6"    � MappingMode$ RelativeToBoundingBox=�63    �� 
StartPoint$ 0.5,0&�6W   .��5      �  � Color$ Black��6    � Offset$ 0Q�6-   � 5      $ 	#FF5B5B5B��6   $ 1Q�61   � 5      $ 	#FF9E9FAA��6   5      .+�5   
   � $	��300��6   $��Center=�6   $��Center=�6:   $	��400��6U   .+�5      �� $��50��6   $	��400��6!   $��
0,34,0,116q�6-   
������� �� CornerRadius$ 8��6T    5        5      ._�5      �� -   5         ��Name$ 
txtUsuario��5      $��50��6/   $	��400��6;   $��16(�6H   
������ $��0q�6o   ���	#00ABADB3$��Center=�6�   $
��Left=�6�   $��Center=�6�   5      �� 5      $��50��6   $	��400��6!   $��
0,129,0,21q�6-   
�������$ 8��6T    5        5      ._�5      G� -   5        	 G�Name$	 txtcontraseña��5      
 G� Password$
  ��65   $��50��6A   $	��400��6M   $��16(�6Z   
������ $��0q�6�   ���	#00ABADB3$��Center=�6�   $
��Left=�6�   $��Center=�6�   5!      5"      �� 5#      -   5        $��Ingresar��5#      $
��Left=�6(   $��265.376,261.452,0,0q�6C   $	��Top=�6`   $��119.385��6x    � Cursor$
 Hand��6�    � ToolTip$ Ingresa al sistema��6�   $��16(�6�   $��Segoe WP Black)�6�   $��30.828��6�    J� RenderTransformOrigin$	 1,0&�6�   ��5$      �� 5%       �� Color# � ��6&    5'        5(      5*      �� 5+      -   5         ��Name$ 
lblusuario��5+      $��
Usuario : ��6(   $
��Left=�6=   $��10,47.72,0,0q�6X   $	��Top=�6n   $��16(�6�   $��Segoe WP Black)�6�   �� 5,      -   5        $ lblcontraseña��5,      $��Contraseña : ��6+   $
��Left=�6C   $��10,142.72,0,126q�6^   $��16(�6w   $��Segoe WP Black)�6�   �� 5-      -   5        $ 	lbltitulo��5-      $��Ingresa al sistema��6'   $��Center=�6D   $	��Top=�6a   $��16(�6z   $��Segoe WP Black)�6�   5/      50      51      