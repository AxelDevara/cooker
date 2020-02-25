package main

import (
	"context"
	proto "protos"
)

type server struct{}

func main() {

}

func (s *server) GetPost(ctx context.Context, request *proto.GetPostReq) (*proto.GetPostRes, error) {
	return proto.GetPostRes, nil
}
