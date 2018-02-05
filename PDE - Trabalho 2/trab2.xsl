<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" encoding="UTF-8"
		method="html" />

	<xsl:key use="@id_receita" name="Receita" match="receita" />
	<xsl:key use="@ingrediente" name="Ingrediente" match="refer_ingrediente" />

	<xsl:template match="livro_receitas">
		<html>
			<head>
				<title>Trabalho 2 - PDE</title>
				<!-- Estrutura do documneto -->
				<xsl:call-template name="validar_estrutura" />

				<!-- Estrutura do Descriçao -->
				<xsl:call-template name="validar_descricao" />

				<!-- Data de publicaçao -->
				<xsl:call-template name="validar_data" />

				<link rel="stylesheet" type="text/css" href="trab2.css" />
			</head>

			<body>
				<xsl:apply-templates select="cabeçalho" />
				<xsl:apply-templates select="corpo" />
			</body>
		</html>
	</xsl:template>

	<!-- Folha de rosto -->
	<xsl:template match="cabeçalho">

		<div id="cabecalho">
			<h1>
				<xsl:value-of select="titulo_do_conjunto_de_receitas" />
			</h1>

			<div id="autores">
				<xsl:value-of select="autores" />
			</div>

			<div id="data_publicacao">
				<xsl:value-of select="data_publicaçao" />
			</div>

			<div id="resumo">
				<xsl:value-of select="resumo" />
			</div>
		</div>
		<br />
	</xsl:template>

	<!-- Corpo do documento -->
	<xsl:template match="corpo">
		<div id="corpo">
			<div id="navegacao">

				<h2> Navegação</h2>
				<ul>
					<xsl:if test="parte">
						<xsl:apply-templates select="parte" mode="indice" />
					</xsl:if>

					<xsl:if test="secçao">
						<xsl:apply-templates select="secçao" mode="indice" />
					</xsl:if>

					<xsl:if test="sub_secçao">
						<xsl:apply-templates select="sub_secçao" mode="indice" />
					</xsl:if>

					<xsl:if test="receita">
						<xsl:apply-templates select="receita" mode="indice" />
					</xsl:if>
				</ul>
			</div>

			<div id="conteudo">
				<xsl:if test="parte">
					<xsl:apply-templates select="parte" mode="conteudo" />
				</xsl:if>

				<xsl:if test="secçao">
					<xsl:apply-templates select="secçao" mode="conteudo" />
				</xsl:if>

				<xsl:if test="sub_secçao">
					<xsl:apply-templates select="sub_secçao" mode="conteudo" />
				</xsl:if>

				<xsl:if test="receita">
					<xsl:apply-templates select="receita" mode="conteudo" />
				</xsl:if>
			</div>
			
		</div>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="parte" mode="indice">
		<li>
			<a HREF="#{generate-id()}">
				<xsl:value-of select="titulo" />
			</a>

			<ul>
				<xsl:apply-templates select="secçao" mode="indice" />
			</ul>
		</li>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="secçao" mode="indice">
		<li>
			<a HREF="#{generate-id()}">
				<xsl:value-of select="titulo" />
			</a>

			<ul>
				<xsl:apply-templates select="sub_secçao" mode="indice" />
			</ul>
		</li>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->
	<xsl:template match="sub_secçao" mode="indice">
		<li>
			<a HREF="#{generate-id()}">
				<xsl:value-of select="titulo" />
			</a>

			<ul>
				<xsl:apply-templates select="receita" mode="indice" />
			</ul>
		</li>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="receita" mode="indice">
		<li>
			<a HREF="#{generate-id(key('Receita', @id_receita))}">
				<xsl:value-of select="nome" />
			</a>
		</li>

	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="parte" mode="conteudo">
		<xsl:for-each select=".">

			<xsl:element name="div">
				<xsl:attribute name="id"> 
					<xsl:value-of select="@tipo" /> 
				</xsl:attribute>

				<h2>
					<a name="{generate-id()}">
						<xsl:value-of select="titulo" />
					</a>
				</h2>

				<p>
					<xsl:value-of select="introducao" />
				</p>

				<xsl:if test="refer_url">
					<xsl:apply-templates select="refer_url" />
				</xsl:if>

				<xsl:if test="secçao">
					<xsl:apply-templates select="secçao" mode="conteudo" />
				</xsl:if>

				<xsl:if test="sub_secçao">
					<xsl:apply-templates select="sub_secçao" mode="conteudo" />
				</xsl:if>

				<xsl:if test="receita">
					<xsl:apply-templates select="receita" mode="conteudo" />
				</xsl:if>
			</xsl:element>

		</xsl:for-each>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="secçao" mode="conteudo">
		<xsl:for-each select=".">

			<xsl:element name="div">
				<xsl:attribute name="id"> 
					<xsl:value-of select="@tipo" />
				</xsl:attribute>

				<h3>
					<a name="{generate-id()}">
						<xsl:value-of select="titulo" />
					</a>
				</h3>

				<p>
					<xsl:value-of select="introducao" />
				</p>

				<xsl:if test="refer_url">
					<xsl:apply-templates select="refer_url" />
				</xsl:if>

				<xsl:if test="sub_secçao">
					<xsl:apply-templates select="sub_secçao" mode="conteudo" />
				</xsl:if>

				<xsl:if test="receita">
					<xsl:apply-templates select="receita" mode="conteudo" />
				</xsl:if>
			</xsl:element>

		</xsl:for-each>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="sub_secçao" mode="conteudo">
		<xsl:for-each select=".">

			<xsl:element name="div">
				<xsl:attribute name="id"> 
					<xsl:value-of select="@tipo" /> 
				</xsl:attribute>

				<h4>
					<a name="{generate-id()}">
						<xsl:value-of select="titulo" />
					</a>
				</h4>

				<p>
					<xsl:value-of select="introducao" />
				</p>

				<xsl:if test="refer_url">
					<xsl:apply-templates select="refer_url" />
				</xsl:if>

				<xsl:if test="receita">
					<xsl:apply-templates select="receita" mode="conteudo" />
				</xsl:if>
			</xsl:element>

		</xsl:for-each>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->
	<xsl:template match="receita" mode="conteudo">
		<xsl:for-each select=".">

			<xsl:element name="fieldset">
				<xsl:attribute name="id"> 
					<xsl:value-of select="@id_receita" /> 
				</xsl:attribute>

				<legend>
					<a name="{generate-id(key('Receita', @id_receita))}">
						<xsl:value-of select="nome" />
					</a>
				</legend>

				<xsl:if test="refer_url">
					<xsl:apply-templates select="refer_url" />
				</xsl:if>

				<p>
					<b>Dificuldade: </b>
					<xsl:value-of select="@dificuldade" />
				</p>

				<p>
					<b>Tempo: </b>
					<xsl:value-of select="@tempo" />
				</p>

				<p>
					<b>Calorias: </b>
					<xsl:value-of select="calorias" />
					kcal
				</p>

				<xsl:if test="lista_ingredientes">
					<xsl:apply-templates select="lista_ingredientes" />
				</xsl:if>

				<xsl:if test="descriçao">
					<xsl:apply-templates select="descriçao" />
				</xsl:if>
			</xsl:element>

		</xsl:for-each>
	</xsl:template>


	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="lista_ingredientes">
		<xsl:element name="div">
		
			<h4>Lista de ingredientes</h4>
			<xsl:for-each select="ingrediente">
				<ul>
					<li>
						<xsl:value-of select="./quantidade" />
						<xsl:value-of select="./unidade" />
						de
						<xsl:value-of select="./nome" />
					</li>
				</ul>
				<xsl:call-template name="validar_refer_ingrediente" />
			</xsl:for-each>
		</xsl:element>

	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="descriçao">
		<xsl:element name="div">

			<h4>Procedimento</h4>
			
			<xsl:if test="lista_passos">
				<xsl:apply-templates select="lista_passos" />
			</xsl:if>

			<xsl:if test="texto">
				<xsl:apply-templates select="texto" />
			</xsl:if>
		</xsl:element>

	</xsl:template>


	<xsl:template match="lista_passos">

		<xsl:for-each select="passo">
			<p>
				<xsl:number format="1 -" />
				<xsl:apply-templates />
			</p>
		</xsl:for-each>

	</xsl:template>


	<xsl:template match="passo">
		<xsl:apply-templates />
	</xsl:template>


	<xsl:template match="texto">
		<p>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<!-- /////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="refer_ingrediente">
		<xsl:element name="b">
			<xsl:variable name="aux" select="@ingrediente" />
			<xsl:value-of select="//ingrediente[@id_ingrediente = $aux]/nome" />
		</xsl:element>
	</xsl:template>


	<xsl:template match="refer_receita">
		<a HREF="#{generate-id(key('Receita', @receita))}">
			<xsl:variable name="aux" select="@receita" />
			<xsl:value-of select="//receita[@id_receita = $aux]/nome" />
		</a>
	</xsl:template>


	<xsl:template match="refer_url">

		<xsl:element name="img">
			<xsl:attribute name="src">
                <xsl:value-of select="@url" />
              </xsl:attribute>
			<xsl:attribute name="alt">
              	<xsl:value-of select="@alt" />
              </xsl:attribute>
		</xsl:element>

	</xsl:template>

	<!-- Validaçoes -->

	<xsl:template name="validar_refer_ingrediente">
		<xsl:if test="count(key('Ingrediente',@id_ingrediente)) = 0">
			<xsl:message terminate="no">
				Erro: Falta de referencias a ingredientes
			</xsl:message>
		</xsl:if>
	</xsl:template>


	<xsl:template name="validar_estrutura">
		<xsl:variable name="nPartes" select="count(//parte)" />
		<xsl:variable name="nSecçoes" select="count(//secçao)" />
		<xsl:variable name="nSub_secçoes" select="count(//sub_secçao)" />
		<xsl:variable name="nReceitas" select="count(//receita)" />

		<!-- <xsl:message> partes - <xsl:value-of select="$nPartes"/> secçoes - 
			<xsl:value-of select="$nSecçoes"/> sub - <xsl:value-of select="$nSub_secçoes"/> 
			receitas - <xsl:value-of select="$nReceitas"/> </xsl:message> -->

		<xsl:if
			test="$nPartes = 0 and $nSecçoes = 0 and $nSub_secçoes = 0 and $nReceitas = 0 ">
			<xsl:message terminate="no">
				Erro: Livro de receitas mal construido
			</xsl:message>
		</xsl:if>
	</xsl:template>


	<xsl:template name="validar_descricao">
		<xsl:variable name="nPassos" select="count(//passo)" />
		<xsl:variable name="nTexto" select="count(//texto)" />
		<!-- passos -> <xsl:value-of select="$nPassos"/> texto -> <xsl:value-of 
			select="$nTexto"/> -->

		<xsl:if test="$nPassos = 0 and $nTexto = 0">
			<xsl:message terminate="no">
				Erro: Falta de descriçao
			</xsl:message>
		</xsl:if>
	</xsl:template>


	<xsl:template name="validar_data">
		<xsl:variable name="data" select="//data_publicaçao" />
		<xsl:variable name="mes" select="number(substring($data, 6, 2))" />
		<xsl:variable name="dia" select="number(substring($data, 9, 2))" />

		<xsl:if test="$mes &gt; 12 or $mes = 0 or $dia &gt; 31 or $dia = 0   ">
			<xsl:message terminate="no">
				Erro: Data inválida
			</xsl:message>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>