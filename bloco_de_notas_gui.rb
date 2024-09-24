require 'tk'
require 'tkextlib/tile'

class BlocoNotas
  def initialize
    @root = TkRoot.new { title "Bloco de Notas" }
    @texto = TkText.new(@root) do
      pack(side: 'top', fill: 'both', expand: true)
      font 'Arial 12'
    end

    criar_menu
    Tk.mainloop
  end

  def criar_menu
    menu_bar = TkMenu.new(@root)
    @root.menu(menu_bar)

    arquivo_menu = TkMenu.new(menu_bar)
    menu_bar.add('cascade', menu: arquivo_menu, label: 'Arquivo')

    arquivo_menu.add('command', label: 'Novo', command: method(:novo_arquivo))
    arquivo_menu.add('command', label: 'Abrir', command: method(:abrir_arquivo))
    arquivo_menu.add('command', label: 'Salvar', command: method(:salvar_arquivo))
    arquivo_menu.add('separator')
    arquivo_menu.add('command', label: 'Sair', command: -> { exit })
  end

  def novo_arquivo
    @texto.delete('1.0', 'end')
  end

  def abrir_arquivo
    caminho = Tk.getOpenFile
    return if caminho.empty?

    conteudo = File.read(caminho)
    @texto.delete('1.0', 'end')
    @texto.insert('end', conteudo)
  end

  def salvar_arquivo
    caminho = Tk.getSaveFile
    return if caminho.empty?

    File.write(caminho, @texto.get('1.0', 'end'))
  end
end

# Executar o bloco de notas
BlocoNotas.new
