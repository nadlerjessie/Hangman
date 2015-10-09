module Graphic

  def classic
    if user.lives == 6
      puts "------------"
      puts "|"     
      puts "|"     
      puts "|"   
      puts "|"     
      puts "|"   
      puts "|"  
    elsif user.lives == 5
      puts "------------"
      puts "|     |"
      puts "|"     
      puts "|"   
      puts "|"     
      puts "|"   
      puts "|"  
    elsif user.lives == 4
      puts "------------"
      puts "|     |"
      puts "|     O"
      puts "|"   
      puts "|"     
      puts "|"  
      puts "|"   
    elsif user.lives == 3
      puts "------------"
      puts "|     |"
      puts "|     O"
      puts "|   -----"
      puts "|"    
      puts "|"    
      puts "|"   
    elsif user.lives == 2
      puts "------------"
      puts "|     |"
      puts "|     O"
      puts "|   -----"
      puts "|     |"
      puts "|"    
      puts "|"   
    elsif user.lives == 1
      puts "------------"
      puts "|     |"
      puts "|     O"
      puts "|   -----"
      puts "|     |"
      puts "|    /"
      puts "|   /"  
    elsif user.lives == 0
      puts "------------"
      puts "|     |"
      puts "|     O"
      puts "|   -----"
      puts "|     |"
      puts "|    / \\"
      puts "|   /   \\"
  end



end