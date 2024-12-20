Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE8154BE5
	for <gfs2@lists.linux.dev>; Fri, 20 Dec 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678872; cv=none; b=P4c7ZpoVXvYetVD9BM/Z7kHWH5EMj0vPs3qIM0AM+JTzrLDygCgIbkMcJMx31pn+AbBgvxxMbQpSXz88RDlBlEEG6dSIxyaXHdvCIvq7CgQS3B3faqlZGrVIoztd1fnjAAyeZNQVJ5xDAOeagLm3tG+uZjMhY2A59/NYfok9Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678872; c=relaxed/simple;
	bh=w6jQahYOlqcvz7yS2bFLVZHGIfXSUVpEPFdjG+/gPFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUVU76X9ASJnHEarSyUyF0XdWjpTdZgv0bKaih5EdXMhotp+m+UJqi0+bzl71I8F/KSdc3lP1DJArXhAL4MqNEPLlV/7L8MUxj0Ws9+KJ2gfTxU+gBbbduh10BuvTvR1nAYwg/hnscAM7nwh2MGYZmsT0dZ7BBo0iWw7E1fSQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VqEPNKS4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VqEPNKS4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68f1bso241530a12.3
        for <gfs2@lists.linux.dev>; Thu, 19 Dec 2024 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734678869; x=1735283669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pPT4Ss30Y6zniOYf5yFL384p54voYpZd+r3GERbLDE=;
        b=VqEPNKS4lqQ8w55Eb3KwSH8HlXX+m4O36BX79O6FH5BErFnAGiSKNJoUa57RdF4ncv
         BfK19fDrRd/9OGkPN2L/Pu04dCTrstYYsoO02nYrIb/PEgXLTiftJxw5yBusi+2QhtoP
         dIo/T5r/nhfr449hh9k8bcw8Z5DZB7TnYLXTSurp/fGbhaapGsUL/VF5Zlcs1qQbXl2Y
         oSzNRFoZrwg35/jM/MbCjnkqMvjkccJ1MyRsT0cQEClYLcrgq5Exb/mKyuHE2vz4NSpc
         HMYTGP6WbRkysigMLwOdRF4CON2Nb5YpIlKmzGtia1hGhaHhaGQsNTUAMhA2vlMtr76S
         LE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734678869; x=1735283669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pPT4Ss30Y6zniOYf5yFL384p54voYpZd+r3GERbLDE=;
        b=RIvcb9XWPS+jvj66UbQr19g9hcwCeT/XRj/SDNlv6MoOSjbpvyhWkrzii7rPlyd8jy
         BJocsP3dEES3OEUgGxFUb+b7/VSQWnB5MOuLloYr5+Eu69ICf0k53hz++a5iWBMuP9ZA
         A6y1x6WMlOutmeRDTTrT25uEjYGGuSctfmwAXMQlv71G7mb/ab6Cg1dQxEGWQOjOQq6Q
         v0t9ndvCtAczfLoQr62BZIG4g1I1gAExpbNBeIzEfwqHtLoX0JB9GZ9V4oLN1c1a8W+q
         A+xaPXSfE1ZyoJFc279s56GqO8lPt+1MQao2YCsW4HdgcX+JN+uNh/ZmmK854UsQuOny
         bMGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrN2vNyuSegRDuZeI1HpHd28hIqExNmzAlFt+koNJcY028+tMo+d2PJVUJk9AXfrJqxNTP@lists.linux.dev
X-Gm-Message-State: AOJu0YyNECFgdMq8RaWIVLb/kMnS9Nxh1ge3RO0QdYwj7rhJjEBNFovt
	ubiZgiTxbl5wh7hd/FMimHQxsYcH8bZtD2Bj5tp6yMlVe4r0m176mPfwbunE7IA=
X-Gm-Gg: ASbGnctO66dlWvQd3GkRRgyRt04U9MNVrr45YT8Dw0ntgi0IjChdaKGdZXPppjJlBbt
	5w6GqbbAdv+8hXyiOKwDLZdFL9r0iD7D0SA3+/9EsXvZc1+WaGChnN33pgiFsEoeIVawjvwel/T
	YTP7leP56jToGy2YJqlEnn8ugnAJoDYiElRAa3d1+At5Xxk23c/7K6rerk8g2uEOEFLbWdwMyE0
	u+vyOLtbVOtcM08xzG6HuMmVn+A5DddUlLDYP53MSlFM/K/zml0xnFGffUgnJLTB+MNF+Q=
X-Google-Smtp-Source: AGHT+IFbKiRB2xvaG8KwAJBawbgif5Pa9FDVzZgZSUQZHzrWu/PowrrrCGPDpA9kau5+PzVCvQk1/w==
X-Received: by 2002:a05:6402:1d4f:b0:5d2:7262:9492 with SMTP id 4fb4d7f45d1cf-5d81dd5ac94mr505621a12.2.1734678868897;
        Thu, 19 Dec 2024 23:14:28 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06d9besm4499204a91.40.2024.12.19.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:14:28 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com
Subject: [PATCH 1/1] dlm: increase max number of links for corosync3/knet
Date: Fri, 20 Dec 2024 15:14:17 +0800
Message-ID: <20241220071418.16786-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220071418.16786-1-heming.zhao@suse.com>
References: <20241220071418.16786-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch increases the maximum number of links that can be
used with corosync3/knet. The majority of the changes are in
user space dlm_tools/dlm_controld.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 fs/dlm/config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index e48c4f9686d3..13a3d0b26194 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -23,7 +23,7 @@ struct dlm_config_node {
 
 extern const struct rhashtable_params dlm_rhash_rsb_params;
 
-#define DLM_MAX_ADDR_COUNT 3
+#define DLM_MAX_ADDR_COUNT 8
 
 #define DLM_PROTO_TCP	0
 #define DLM_PROTO_SCTP	1
-- 
2.43.0

