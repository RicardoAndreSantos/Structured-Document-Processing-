<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE rdf:RDF [
 <!ENTITY rdf  "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
 <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
	xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:rel="http://www.dcc.fc.up.pt/~zp/livroReceitas/" >
	
	<xsl:output method="xml" encoding="UTF-8" />
	
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:apply-templates />
		</rdf:RDF>
	</xsl:template>
	
	
	<xsl:template match="livro_receitas">
	
		<rdf:Description rdf:about="{cabeçalho/titulo_do_conjunto_de_receitas/text()}">
		
			<rdf:type rdf:resource="livro_receitas"/>
				
			<dc:title>
				<xsl:value-of select="cabeçalho/titulo_do_conjunto_de_receitas" />
			</dc:title>
			
			<dc:date>
				<xsl:value-of select="cabeçalho/data_publicaçao" />
			</dc:date>
		
			<xsl:apply-templates select="cabeçalho/autores" />
			
			<dc:description>
				<xsl:value-of select="cabeçalho/resumo"/>
			</dc:description>
			
			<xsl:apply-templates select="corpo/parte" />
			
			<xsl:apply-templates select="corpo/secçao" />
			
			<xsl:apply-templates select="corpo/sub_secçao" />
			
			<xsl:apply-templates select="corpo/receita" />
			
		</rdf:Description>
	
	</xsl:template>
	
	
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->
	<xsl:template match="autores">
		
		<dc:author>
			<xsl:value-of select="text()"/>
		</dc:author>
		
		<foaf:name>
			<xsl:value-of select="text()"/>
		</foaf:name>
		
	</xsl:template>
	
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->
	<xsl:template match="parte">
		<rel:indice>
			<rel:Parte>
				<rel:titulo>
				
					<xsl:value-of select="titulo" />
				</rel:titulo>
				
				<xsl:apply-templates select="secçao" />
				
			</rel:Parte>
		</rel:indice>
	</xsl:template>
	
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="secçao">
		<rel:indice>
			<rel:Secçao>
			
				<rel:titulo>
					<xsl:value-of select="titulo" />
				</rel:titulo>
				
				<xsl:apply-templates select="sub_secçao" />

			</rel:Secçao>
		</rel:indice>
	</xsl:template>

<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->
	
	<xsl:template match="sub_secçao">
		<rel:indice>
			<rel:Sub_secçao>
				<rel:titulo>
				
					<xsl:value-of select="titulo" />
				</rel:titulo>
			
				<xsl:apply-templates select="receita" />
			
			</rel:Sub_secçao>
		</rel:indice>
	</xsl:template>

<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->

	<xsl:template match="receita">
		<rel:indice>
			<rel:Receita>
				<rel:titulo>
					
					<xsl:value-of select="nome" />
					
				</rel:titulo>
				
			</rel:Receita>
		</rel:indice>
	
	</xsl:template>

</xsl:stylesheet>