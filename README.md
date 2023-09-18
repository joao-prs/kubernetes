# kubernetes

<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=kubernetes"/>
    <!--
    <img src="https://skillicons.dev/icons?i=bash,kubernetes"/>
    -->
  </a>
</p>

<table>
  <tr>
    <td width=45%>
      Kubernetes , também conhecido como K8s, é um sistema de código aberto para automatizar a implantação, dimensionamento e gerenciamento de aplicativos em contêineres.
    </td>
    <td>
      Ele agrupa contêineres que compõem um aplicativo em unidades lógicas para facilitar o gerenciamento e a descoberta. O Kubernetes se baseia em 15 anos de experiência na execução de cargas de trabalho de produção no Google, combinadas com as melhores ideias e práticas da <a href="https://kubernetes.io/community/">comunidade</a>. 
    </td>
  </tr>
</table>


<!--
<img style="float: right;" src="teste-image-md.png" width=30%>
-->

| Nota | Observação |
| --- | --- |
| CRI v1alpha2 | A partir da versão 1.26 do Kubernetes, foi removido o suporte ao CRI v1alpha2 e ao Containerd 1.5. O repositório oficial do Ubuntu não tem o Containerd 1.6, então precisará usar o repositório do Docker pra instalar o ContainerD. |

### A seguir os requisitos mínimos nossos testes:

- Máquina Linux (aqui no caso vou utilizar Ubuntu 22.04)
- 2 GB de memória RAM
- 2 CPUs
- Conexão de rede entre as máquinas
- Hostname, endereço MAC e product_uuid únicos pra cada nó.
- Swap desabilitado

> Nota: Esses requisitos são o suficiente para os testes, todavia para criar pods e ambientes mais recursos serão necessários. 

### Sumário
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes1.26.md">Guia de instalação.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.concepts.md">Conceitos básicos.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/kubernetes.manifest.md">Arquivo Manifesto.</a>
- <a href="https://github.com/joao-prs/kubernetes/blob/main/doc/kubernetes1.26-extras.md">Conteúdo extra.</a>

> Este repositório está sendo constantemente atualizado, por favor desconsidere a desorganização. Navegue entre os READMEs deste repositório para mais guias. 😊
