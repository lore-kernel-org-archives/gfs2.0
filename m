Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE412E48
	for <gfs2@lists.linux.dev>; Thu,  9 Nov 2023 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LseiTpsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JrmCXtoRr7oqSU3gZeuU9Jf2IqGd/4aYMHqwkCedhGc=; b=LseiTpszMRMo61aMp9dz6hpGXf
	9fJw2q1ir1+ixIC/ENi60/RVQeoSBiflP8k83NOslCq49jYcgJpSoXkaY5CPbtEm5ZYzoZxghrbjt
	QY62wZpYeU8NbuBToKPOVfORO+z54qFD5vPz7CfjD0tYaXD9IHEYnmJk4w7148n097rTfd3iud5zx
	wp7pAaCRITuzXSpHJaoNQmSCCmbxNUbX72HCBG3s5yfXxTXO3WfrdDNSde493X+iKGuZqC4Et/9ur
	fgwabBUiBszT+aI8TR+dAsbhVp0LVIWBPke2ttxmOEQPVczz+dP22ufOMTe/YlW/MYknm6WZCrPhF
	l3OmTCHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r11OD-00EJFR-0D;
	Thu, 09 Nov 2023 09:32:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8D00300454; Thu,  9 Nov 2023 10:31:52 +0100 (CET)
Date: Thu, 9 Nov 2023 10:31:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] refcount: introduce __refcount_dec_and_lock macro
Message-ID: <20231109093152.GS8262@noisy.programming.kicks-ass.net>
References: <20231106191138.3179599-1-aahringo@redhat.com>
 <20231106191138.3179599-2-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106191138.3179599-2-aahringo@redhat.com>

On Mon, Nov 06, 2023 at 02:11:37PM -0500, Alexander Aring wrote:
> This patch adds the __refcount_dec_and_lock macro to generate code for a
> lock specific refcount_dec_and_lock implementation. Existing
> refcount_dec_and_lock implementation are updated to use the new
> __refcount_dec_and_lock macro. In future other lock implementation can
> added to use the refcount_dec_and_lock trick to only hold the lock when
> the refcount is going to be zero. Per subsystem own lock implementation
> can use the macro as well to provide such implementation for their own
> locking type.
> 
> Co-developed: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
