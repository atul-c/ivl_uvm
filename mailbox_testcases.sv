
module mailbox_test(); 
 mailbox my_mailbox; 
   initial begin 
    my_mailbox =new(); 
    if(my_mailbox) 
      begin 
      fork
        put_packets(); 
        get_packets();
       #1000;
      join_any
      end 
      #1000; 
     $display("mailbox check test done"); 
   end 

  task put_packets(); 
  integer i; 
  begin 
   for(i=0;i<10;i++)
    begin 
    #10; 
    my_mailbox.put(i); 
      $display("Putting item %0d at time %0d ns. size is %0d",i, $time, my_mailbox.num()); 
    end 
    end 
   endtask 

  task get_packets(); 
 integer j; 
 begin 
 for(j=0;j<10;j++)
   begin 
   #20; 
   my_mailbox.get(j); 
     $display("Getting item %0d @ %0d ns. size is %0d",j, $time, my_mailbox.num()); 
   end 
 end 
 endtask 
 
 endmodule : mailbox_test
