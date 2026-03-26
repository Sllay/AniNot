import glob, os

files = glob.glob("/home/seluser/venv/**/anipy_server/main.py", recursive=True)
if not files:
    print("main.py nao encontrado!")
    exit(1)

path = files[0]
print(f"Patchando: {path}")

with open(path, "r") as f:
    code = f.read()

old = 'options.add_argument("--no-sandbox")'
new = ('options.add_argument("--no-sandbox")
'
       '        options.add_argument("--dns-prefetch-disable")
'
       '        options.binary_location = "/opt/chrome147/chrome"')

if old not in code:
    print("Alvo nao encontrado no arquivo!")
    exit(1)

code = code.replace(old, new, 1)

with open(path, "w") as f:
    f.write(code)

print("Patch aplicado com sucesso!")
