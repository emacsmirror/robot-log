
# Generate test data.
debug.log: test.robot
	robot --debugfile debug.log --console none test.robot || true

check: debug.log
	emacs -Q -L . -batch -l ert -l tests.el \
	  --eval "(let ((ert-quiet t)) (ert-run-tests-batch-and-exit))"
