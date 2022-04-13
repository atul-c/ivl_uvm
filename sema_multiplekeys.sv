class ivl_uvm_semaphore;

	int cur_key_count;

	function new (int keyCount = 0);
	  this.cur_key_count = keyCount;
	endfunction : new

	function void put (int keyCount = 1);
	  this.cur_key_count += keyCount;
	endfunction : put

	task get (int keyCount = 1);
	  while (this.cur_key_count < keyCount) begin
			#1;
	  end
	  this.cur_key_count -= keyCount;
	endtask : get

	function int try_get (int keyCount = 1);
		try_get = 0;
	  if (this.cur_key_count >= keyCount) begin
		  try_get = this.cur_key_count;
	    this.cur_key_count -= keyCount;
		end
	endfunction : try_get


endclass : ivl_uvm_semaphore


module example;
  ivl_uvm_semaphore sema; //declaring semaphore sema
 
  initial begin
    sema=new(4); //creating sema with '4' keys
      $display("semaphore with %0d keys is created",sema.cur_key_count);

    fork
      display(2); //process-1
      display(3); //process-2
      display(2); //process-3
    join
  end
 
  task automatic display(int key);
    sema.get(key); //getting '2' keys from sema
    $display($time,"\t Simulation Time");
    #20;
    sema.put(key); //putting '2' keys to sema
  endtask
endmodule
