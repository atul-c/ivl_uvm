class semaphore_try;

int cur_key_count;

	function new (int keyCount = 0);
	  this.cur_key_count = keyCount;
	endfunction : new

  function void put (int keyCount = 0);
	  this.cur_key_count += keyCount;
	endfunction : put

  task get (int keyCount = 3);
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

endclass : semaphore_try

module example;
  semaphore_try sema;

	initial begin : operate
      sema = new(9);
     fork
       show(4);
       show(4);
     join
	end : operate
  
  task show(int key);
    sema.try_get(key);
    $display($time,"ns %0d keys left",sema.cur_key_count);
    #20;
    sema.put(key);
  endtask : show

endmodule : example
