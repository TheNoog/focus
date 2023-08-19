

# try:
#     import cirq
# except ImportError:
#     print("installing cirq...")
#     !pip install --quiet cirq
#     import cirq

#     print("installed cirq.")
import cirq

print("Pick a qubit.")
qubit = cirq.GridQubit(0, 0)

print("Create a circuit that applies a square root of NOT gate, then measures the qubit.")
circuit = cirq.Circuit(cirq.X(qubit) ** 0.5, cirq.measure(qubit, key='m'))
print("Circuit:")
print(circuit)

print("Simulate the circuit several times.")
simulator = cirq.Simulator()
result = simulator.run(circuit, repetitions=20)
print("Results:")
print(result)
