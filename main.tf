provider "aws" {
    region = "eu-tu-ceilalti"
    profile = "fericirii19"
}

resource "aws_security_group" "allow_http_inbound" {
    name = "allow_http"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_manb3ast" {
    name = "manb3ast access"

    ingress {
        from_port = 22 
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["999.999.999.999/999"]
    }
}

resource "aws_instance" "digital" {
    ami = "ami-1e339e71"
    instance_type = "t2.micro"
    key_name = "manb3ast"
    vpc_security_group_ids =
        [ "${aws_security_group.allow_http_inbound.id}", "${aws_security_group.allow_manb3ast.id}" ]

    user_data = "${element(data.template_file.user_data_v2.*.rendered, 0)}"

    tags {
        Name = "digital_instance"
        }
    provisioner "file" {
      source      = "/Users/matt/tmp/index.html"
      destination = "/var/tmp/index.html"
        
      connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = "${file("/fericirii/19/manb3ast")}"
            }  
        }
}


data "template_file" "user_data_v2" {
    template = "${file("./le_shop.sh")}"
    vars {
        server_port = "8080"
        }
}

output "server_ip" {
    value = "${aws_instance.digital.public_ip}"
}

output "dns_name" {
    value = "${aws_instance.digital.public_dns}"
}

