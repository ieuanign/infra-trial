package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestRoutes(t *testing.T) {
	cases := []struct {
		path, want string
		status     int
	}{
		{"/health", "ok", http.StatusOK},
		{"/", "Hello from infra-trial.", http.StatusOK},
		{"/nowhere", "", http.StatusNotFound},
	}
	for _, c := range cases {
		rec := httptest.NewRecorder()
		handler().ServeHTTP(rec, httptest.NewRequest(http.MethodGet, c.path, nil))
		if rec.Code != c.status {
			t.Errorf("GET %s: status %d, want %d", c.path, rec.Code, c.status)
		}
		if c.want != "" && strings.TrimSpace(rec.Body.String()) != c.want {
			t.Errorf("GET %s: body %q, want %q", c.path, rec.Body.String(), c.want)
		}
	}
}
