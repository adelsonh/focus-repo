#Exportando nuestra Key SSH

resource "digitalocean_ssh_key" "focus"{
	name="focus"
	public_key="${file("ssh_public_key.pub")}"
}