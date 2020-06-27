all:
	rm -rf *.info app_config catalog node_config  logfiles *_service include *~ */*~ */*/*~;
	rm -rf */*.beam;
	rm -rf *.beam erl_crash.dump */erl_crash.dump */*/erl_crash.dump;
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;
doc_gen:
	rm -rf  node_config logfiles doc/*;
	erlc ../doc_gen.erl;
	erl -s doc_gen start -sname doc
worker:
	rm -rf *_service  *_config erl_crasch.dump;
#	dns_service
	git clone https://github.com/joq62/dns_service.git;	
	cp dns_service/src/*.app dns_service/ebin;
	erlc -o dns_service/ebin dns_service/src/*.erl;
#	boot_service
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;	
#	test
	erlc -D worker -o test_ebin test_src/*.erl;
	erl -pa */ebin -pa ebin -pa test_ebin -boot_service services dns_service -s boot_service_tests start -sname worker_boot_test
master:
	rm -rf *_service  *_config erl_crasch.dump;
#	dns_service
	git clone https://github.com/joq62/dns_service.git;	
	cp dns_service/src/*.app dns_service/ebin;
	erlc -o dns_service/ebin dns_service/src/*.erl;
#	boot_service
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;	
#	test
	erlc -D master -o test_ebin test_src/*.erl;
	erl -pa */ebin -pa ebin -pa test_ebin -boot_service services dns_service -s boot_service_tests start -sname master_boot_test
