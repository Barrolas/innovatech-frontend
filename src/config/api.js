const resolveBase = (envValue, fallback) => {
  if (envValue === "") return "";
  return envValue ?? fallback;
};

export const API_VENTAS_BASE = resolveBase(
  import.meta.env.VITE_API_VENTAS_URL,
  "http://localhost:9080"
);

export const API_DESPACHOS_BASE = resolveBase(
  import.meta.env.VITE_API_DESPACHOS_URL,
  "http://localhost:9081"
);

export const ventasApi = (path = "") => {
  const normalized = path.startsWith("/") ? path : `/${path}`;
  return API_VENTAS_BASE === ""
    ? normalized
    : `${API_VENTAS_BASE}${normalized}`;
};

export const despachosApi = (path = "") => {
  const normalized = path.startsWith("/") ? path : `/${path}`;
  return API_DESPACHOS_BASE === ""
    ? normalized
    : `${API_DESPACHOS_BASE}${normalized}`;
};
