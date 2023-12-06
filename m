Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C531096B
	for <gfs2@lists.linux.dev>; Wed,  6 Dec 2023 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="izYy211M"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c68da9d639so2010679a12.3
        for <gfs2@lists.linux.dev>; Tue, 05 Dec 2023 22:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842795; x=1702447595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8wgNl1PchXcHI5F0qOFxbj06sbuE+5yXttvrgVz+ro=;
        b=izYy211MqX6bUpmz7F3ax2GxltffF0ZlT+vLa1IxcxkOFohbVsIbbb9mWRwBM5ObvH
         Ow4weZcgwkNpYbK/NEuHPHVI378Aay4/KM2peAHwn25l9KIJAXPBb/TjncU260+quhAt
         cdy4p74HD+yTLGe/Y6I8VKrGEIMlDA30VILBVjqQXOkDfczNzBrhVos2chUNLKxdrZXv
         5Qbbx4iOEKDbDwurzacOYiuVxTEroGtzwOOYAwT7YNPasFzyh0Sbl6eIUPge2xsJJcj+
         ft9WSlEDG0dphW3sCsXgVmJANZi07mhPxNP+KVAznQDMJgWmta6PMKLYIXAtO8siOl6J
         9VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842795; x=1702447595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8wgNl1PchXcHI5F0qOFxbj06sbuE+5yXttvrgVz+ro=;
        b=F4pQlInelo1qAaN5AVc8olgIi5iFrD40vEKLCtXY1gyi1kNP65gC0u4+SZ8PNL1R19
         7rl/K3M5ePVaQrv2HJYDm9yPWtIjF4l+0DmVtYgavFov9g4OlVHezvHc9a8A4ICyU7dP
         XkbvA4J7XWCJqUnNG60VWptcHrY72rsal6H0cel7rP/ASm+nB3IJejgM8vxi60VuJ2eB
         c85osYD4skSu4WX0ZbXbhI7ft5uBX4RmLb8HG/pp+zQoT0SW311HXMdTj8Am1xAQDNIM
         UHNtv7kHkekVK1ohpTjKpOOihQGoQ4w79X5xsQ78WdG6TA96kA1wEON34Lnom5sdLbA9
         dz4g==
X-Gm-Message-State: AOJu0Yz5/WHdfrX7H9CSbIdg/YshXx7G2iTqtvNhbHGoKk7PXRVDniDK
	9phhQzHJE7yI7TZo10V/yW3Bjg==
X-Google-Smtp-Source: AGHT+IEdPXfNmvKvrswUKJHm+sFsPS7aPY/u0WjJJT2ny1b5k9BwlvRmtzalQC13yVeEtaaHy4KiTw==
X-Received: by 2002:a05:6a20:c19e:b0:18f:97c:8254 with SMTP id bg30-20020a056a20c19e00b0018f097c8254mr292006pzb.94.1701842794864;
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001d0c5037ed3sm2322833pls.46.2023.12.05.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:33 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3I-004VOz-0c;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVV-32vJ;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] hlist-bl: add hlist_bl_fake()
Date: Wed,  6 Dec 2023 17:05:36 +1100
Message-ID: <20231206060629.2827226-8-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

in preparation for switching the VFS inode cache over the hlist_bl
lists, we nee dto be able to fake a list node that looks like it is
hased for correct operation of filesystems that don't directly use
the VFS indoe cache.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/list_bl.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..8ee2bf5af131 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -143,6 +143,28 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
+/**
+ * hlist_bl_add_fake - create a fake list consisting of a single headless node
+ * @n: Node to make a fake list out of
+ *
+ * This makes @n appear to be its own predecessor on a headless hlist.
+ * The point of this is to allow things like hlist_bl_del() to work correctly
+ * in cases where there is no list.
+ */
+static inline void hlist_bl_add_fake(struct hlist_bl_node *n)
+{
+	n->pprev = &n->next;
+}
+
+/**
+ * hlist_fake: Is this node a fake hlist_bl?
+ * @h: Node to check for being a self-referential fake hlist.
+ */
+static inline bool hlist_bl_fake(struct hlist_bl_node *n)
+{
+	return n->pprev == &n->next;
+}
+
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
 	bit_spin_lock(0, (unsigned long *)b);
-- 
2.42.0

