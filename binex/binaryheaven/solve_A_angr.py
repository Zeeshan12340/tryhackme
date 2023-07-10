import angr
import sys

def main(argv):
	b = "./angel_A"
	p = angr.Project(b)
	init = p.factory.entry_state()
	sm = p.factory.simgr(init)
	sm.explore()
	for state in sm.deadended:
		print(state.posix.dumps(sys.stdin.fileno()))

if __name__ == '__main__':
	main(sys.argv)
