import glob

files = glob.glob("/home/seluser/venv/**/anipy_server/main.py", recursive=True)
if not files:
    print("ERRO: main.py nao encontrado!")
    exit(1)

path = files[0]
print("Patchando: " + path)

with open(path, "r") as f:
    lines = f.readlines()

old = '        options.add_argument("--no-sandbox")
'
new = (
    '        options.add_argument("--no-sandbox")
'
    '        options.add_argument("--dns-prefetch-disable")
'
    '        options.binary_location = "/opt/chrome147/chrome"
'
)

content = "".join(lines)
if old not in content:
    print("ERRO: alvo nao encontrado!")
    exit(1)

content = content.replace(old, new, 1)

with open(path, "w") as f:
    f.write(content)

print("Patch aplicado com sucesso!")
